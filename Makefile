VERSION = `git rev-parse --short HEAD`

default:
	docker build -t docker.io/haiku/website-gemini:${VERSION} .
push:
	docker push docker.io/haiku/website-gemini:${VERSION}
test:
	docker kill website-gemini-test || true
	docker rm website-gemini-test || true
	docker run --name website-gemini-test -p 1965:1965 docker.io/haiku/website-gemini:${VERSION}
clean:
	docker kill website-gemini-test || true
	docker rm website-gemini-test || true
