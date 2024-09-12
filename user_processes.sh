#!/bin/bash

# Script to list proceses of the current user

echo "Welcome to processes printer, how do you want to sort the processes:"
echo "1) Sort processes by CPU"
echo "2) Sort processes by RAM"

read -rp "Select the number of your option: " p

if [[ $p == 1 ]]; then
    SORT="pcpu"
elif [[ $p == 2 ]]; then
    SORT="rss"
else
    echo "Option $p is not supported."
    exit 1
fi

read -rp "How many processes you want to print? " pn

if [[ $pn =~ ^[1-9][0-9]*$ ]]; then
    pn=$(("$pn" + 1))
    ps aux --sort="-$SORT" | grep -e "$USER" -e 'USER.*PID.*%CPU.%MEM' | head -n $pn
else
    echo "$pn must be a positive interget."
    exit 1
fi

  
