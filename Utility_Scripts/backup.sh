#!/bin/bash

#Argument Number Handler
if [ $# -ne 0 ]; then
	echo "Usage: This Script Does Not Take Any Command Line Arguments"
	exit 1
fi

udevadm info --query=all --name=sdb #| grep -E "MODEL=|VENDOR=|PATH="

exit 0