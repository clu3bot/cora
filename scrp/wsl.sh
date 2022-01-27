#!/bin/bash
set -e
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    echo "wsl" > temp/wsl.txt
else
    sleep 0.1
fi
