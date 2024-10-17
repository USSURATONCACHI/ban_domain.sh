#!/bin/bash
set -e
ip route | grep default | awk '{print $5}'
