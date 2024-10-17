#!/bin/bash

set -e

if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <network_device>" >&2
        exit 1
fi

DEVICE=$1

RES=$(ip -o -f inet addr show $DEVICE)

echo "$RES" | awk '{print $4}' | cut -d'/' -f1
