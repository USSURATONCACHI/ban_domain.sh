#!/bin/bash

set -e

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <table_name> <table_id>"
	exit 1
fi

./check_root.sh

TABLE_NAME=$1
TABLE_ID=$2

sudo sysctl -w net.ipv4.ip_forward=1

set +e
RTFILE=/etc/iproute2/rt_tables
if [ -z "$(cat $RTFILE | grep $TABLE_NAME)" ]; then
	echo "Creating ip table $TABLE_NAME"
	echo "$TABLE_ID $TABLE_NAME" | sudo tee -a $RTFILE
fi
