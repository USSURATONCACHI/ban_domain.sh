#!/bin/bash

# set -e

# Check if the domain name is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: cat my_ip_list.txt | $0 <device>"
    exit 1
fi
./check_root.sh

DEVICE=$1
IP_ADDRESSES=$(cat -)

if [ -z "$IP_ADDRESSES" ]; then
	echo "Nothing is given via stdin (expected IP addresses)"
	exit 3
fi

# Apply the command to each IP address
for IP in $IP_ADDRESSES; do
	echo "Unbanning $IP..."
	iptables -D OUTPUT -o $DEVICE -d $IP -j REJECT
done
