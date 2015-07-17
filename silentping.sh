#!/bin/bash

host="$1"
msg_up=" up "
msg_down="down"

ping -c 2 $1 &>/dev/null
if [[ $? -eq 0 ]]
then
	echo "$msg_up"
else
	echo "$msg_down"
fi
