#!/bin/bash

interface=$(cat int.txt)

x=$(iwconfig 2>&1 | grep -n $interface | awk '{ print $1 }' | cut -d: -f1)

iwconfig 2>&1 | awk 'NR=='$x'' | awk '{ print $1 }'