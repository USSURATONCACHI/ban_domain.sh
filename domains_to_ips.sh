#!/bin/bash

set -e

if [ "$#" -ne 0 ]; then
    echo "Usage: echo google.com | $0" >&2
    exit 1
fi

IP_ADDRESSES_FILE=$(mktemp)

query_ips () {
	DOMAIN=$1
	RESULT=$(dig +short "$DOMAIN")

	if [ -z "$RESULT" ]; then
		echo "Received nothing for domain $DOMAIN" >&2
	else
		ERRS=$(printf "%s" "$RESULT" | grep ";;" | wc -l)
		LNS=$(printf "%s" "$RESULT" | grep -v ";;" | wc -l)
		echo "Received $ERRS errors and $LNS lines for domain $DOMAIN" >&2
		printf "%s\\n" "$RESULT" >> $IP_ADDRESSES_FILE
	fi
}

for DOMAIN in $(cat -); do
	query_ips "$DOMAIN" &
done
wait


# -- Check for errors
ERRORS_COUNT=$(cat $IP_ADDRESSES_FILE | grep ";;" | wc -l)
echo "Received $ERRORS_COUNT errors" >&2
echo Full list of IPs stored at $IP_ADDRESSES_FILE >&2

# -- Sort, dedup, and prettify IPs list
cat $IP_ADDRESSES_FILE | grep -v ";;" | sort | uniq
