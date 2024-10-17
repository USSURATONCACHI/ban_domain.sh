#!/bin/bash
if [ "$EUID" -ne 0 ]; then
        echo "----" >&2
        echo "FATAL: Editing iptables requires elevated priviledes. This script must be run as root." >&2
        echo "----" >&2
        exit 2
fi
