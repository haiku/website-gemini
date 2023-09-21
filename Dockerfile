# Build phase
FROM docker.io/rust:alpine AS builder
RUN wget -O source.tar.gz $(wget -qO- https://api.github.com/repos/mbrubeck/agate/releases/latest | sed -nE 's/^.*"tarball_url"\s*:\s*"([^"]+)".*$/\1/p') && \
	tar xzf source.tar.gz && \
	mv mbrubeck-agate-* /agate
WORKDIR /agate
RUN apk --no-cache add libc-dev && \
    cargo install --target x86_64-unknown-linux-musl --path .

# Final container
FROM docker.io/alpine:3.18
RUN apk --update add openssl
COPY --from=builder /usr/local/cargo/bin/agate /usr/bin/agate
ADD content/. /gmi/
WORKDIR /app
COPY start.sh /app
ENTRYPOINT ["/bin/sh", "start.sh"]
