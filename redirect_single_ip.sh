#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

if [ "$#" -ne 4 ]; then
	echo "Usage: $0 <table_name> <to_net_device> <to_gateway> <ip>" >&2
	exit 1
fi

./check_root.sh

TABLE_NAME=$1
TO_DEV=$2
TO_GATE=$3
IP=$4

echo "Redirecting IP $IP. To $TO_GATE (destination of $TO_DEV)"
set +e

sudo ip route add $IP via $TO_GATE dev $TO_DEV table $TABLE_NAME
sudo ip rule add to $IP lookup $TABLE_NAME

