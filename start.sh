#!/bin/sh

if [ -z "$LANG" ]; then
	export LANG="en"
fi

if [ -z "$TLS_HOSTNAME" ]; then
	export TLS_HOSTNAME="localhost"
fi

TLS_PATH=/app/.certificates/$TLS_HOSTNAME

# Agate only deals in DER's :-|
for i in $(find /certs/ -name "*.crt" | head -1); do
	mkdir -p $TLS_PATH
	BASE=$(basename $i ".crt")
	echo "Converting Certificate $i to DER..."
	openssl x509 -in $i -out $TLS_PATH/cert.der -outform DER
done

for i in $(find /certs/ -name "*.key" | head -1); do
	mkdir -p $TLS_PATH
	BASE=$(basename $i ".key")
	echo "Converting Key $i to DER..."
	openssl rsa -in $i -out $TLS_PATH/key.der -outform DER
done

exec agate --content /gmi/ \
	--hostname ${TLS_HOSTNAME} \
	--lang ${LANG}
