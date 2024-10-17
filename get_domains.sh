#!/bin/bash

set -e

if [ -z "$1" ]; then
	echo "Usage: $0 <top_domain>"
	exit 1
fi

DOMAIN=$1

LINK="https://crt.sh/?q=%.$DOMAIN&output=json"
RESPONSE=$(curl -s $LINK)
RETRIES=0

while [[ $RETRIES -lt 3 && -z "$RESPONSE" ]]; do
	RETRIES=$((RETRIES + 1))
	echo "crt.sh failed to response, retrying $RETRIES..." >&2
	RESPONSE=$(curl -s $LINK)
done

if [ -z "$RESPONSE" ]; then
	echo "crt.sh failed to response after $RETRIES retries" >&2
	exit 2
fi

ALL_SUBDOMAINS=$(printf "%s" "$RESPONSE" | \
	grep -oP '"name_value":"\K[^"]+' | \
	sed "s/\\\\n/\\n/g" | \
	grep -v "^\\*\\."
	)

printf "%s\\n%s" "$DOMAIN" "$ALL_SUBDOMAINS" | sort | uniq
