#!/bin/bash

# set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: cat IPS.txt | $0 <device>"
    exit 1
fi
./check_root.sh

DEVICE=$1

IP_ADDRESSES=$(cat - | sort | uniq)

# -- Check if there are any
if [ -z "$IP_ADDRESSES" ]; then
    echo "Nothing is given via stdin (expected IP addresses)"
    exit 3
fi

# -- Ban all of them
for IP in $IP_ADDRESSES; do
    echo "Banning $IP..."
    iptables -A OUTPUT -o $DEVICE -d $IP -j REJECT
done

