#!/bin/bash

set -e

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <table_name>"
	exit 1
fi

./check_root.sh

TABLE_NAME=$1

set +e
RTFILE=/etc/iproute2/rt_tables
if [ -z "$(cat $RTFILE | grep $TABLE_NAME)" ]; then
        echo "Removing ip table $TABLE_NAME"
	cat $RTFILE | grep -v "$TABLE_NAME" > $RTFILE
fi

