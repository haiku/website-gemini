#!/bin/sh

if [ -z "$LANG" ]; then
	export LANG="en"
fi

if [ -z "$TLS_HOSTNAME" ]; then
	export TLS_HOSTNAME="localhost"
fi

exec agate --content /gmi/ \
	--hostname ${TLS_HOSTNAME} \
	--lang ${LANG}
