#!/bin/sh

if [ -z "$LANG" ]; then
	export LANG="en"
fi

if [ -z "$TLS_HOSTNAME" ]; then
	export TLS_HOSTNAME="localhost"
fi

TLS_PATH=/app/.certificates/$TLS_HOSTNAME
mkdir -p $TLS_PATH

if [ ! -d /certs ]; then
	echo "No certificates found for $TLS_HOSTNAME, making self-signed certificate..."
	mkdir -p /certs
	openssl req -subj "/CN=$TLS_HOSTNAME/O=Haiku/C=US" -new -newkey rsa:2048 -sha256 \
		-days 14 -nodes -x509 -keyout /certs/$TLS_HOSTNAME.key -out /certs/$TLS_HOSTNAME.crt
fi

echo "Found certificates, converting to DER..."
# Agate only deals in DER's :-|
for i in $(find /certs/ -name "*.crt" | head -1); do
	BASE=$(basename $i ".crt")
	echo "Converting Certificate $i to DER..."
	openssl x509 -in $i -out $TLS_PATH/cert.der -outform DER
done

for i in $(find /certs/ -name "*.key" | head -1); do
	BASE=$(basename $i ".key")
	echo "Converting Key $i to DER..."
	openssl rsa -in $i -out $TLS_PATH/key.der -outform DER
done

echo "agate is ready to serve gemini://$TLS_HOSTNAME"

exec agate --content /gmi/ \
	--hostname ${TLS_HOSTNAME} \
	--lang ${LANG}
