#!/bin/bash

set -e

if [ "$#" -ne 3 ]; then
	echo "Usage: $0 <to_net_device> <to_gateway> <top_domain>"
	exit 1
fi

./check_root.sh

TO_DEV=$1
TO_GATE=$2
DOMAIN=$3

./get_domains.sh $DOMAIN | ./domains_to_ips.sh | ./redirect_ips.sh $TO_DEV $TO_GATE
