#!/bin/bash

# set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: cat IPS.txt | $0 <to_net_device> <to_gate>"
    exit 1
fi

./check_root.sh

TO_DEV=$1
TO_GATE=$2
TABLE_NAME=alt_device

IP_ADDRESSES=$(cat - | sort | uniq)

if [ -z "$IP_ADDRESSES" ]; then
    echo "Nothing is given via stdin (expected IP addresses)"
    exit 3
fi

for IP in $IP_ADDRESSES; do
	echo "Removing redirect on $IP (to $TO_DEV)..."
	./unredirect_single_ip.sh $TABLE_NAME $TO_DEV $TO_GATE "$IP" > /dev/null
done
