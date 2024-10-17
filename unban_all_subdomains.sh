#!/bin/bash

set -e

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <network_device> <top_domain>"
	exit 1
fi

./check_root.sh

DEVICE=$1
DOMAIN=$2

./get_domains.sh $DOMAIN | ./domains_to_ips.sh | ./unban_ips.sh $DEVICE
