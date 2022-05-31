#!/bin/bash
#

iface=$(sudo python3 rename.py)

if [[ -z "${iface// }" ]]; then
    iface="eth0"
fi

if [[ "${iface}" == "eth0" ]]; then
    mode="Wired Connection"
else
    mode=$(iwconfig "$iface" | sed -n '/Mode:/s/.*Mode://; s/ .*//p')
fi

if [ "$mode" == "Monitor" ]; then 
    Mod=Monitor 
else 
    Mod=Managed 
fi

echo $Mod