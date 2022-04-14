#!/bin/bash

deauth() {
    echo "Deauth Options"\n
    echo "[1] Use Whitelist Mode"
    echo "[2] Use Blacklist Mode"
    echo "[3] Deauth Everyone"

}

check_iface() {
        iface=$(airmon-ng | awk 'NR==4' | awk '{print $2}')

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
}

check_eth0() {
    if [ "${iface}" == "eth0" ]; then
        eth0_prompt 
    fi
}

eth0_prompt() {
    clear
    ewr "${LRED}Error Connecting. Try using a Wireless Interface as opposed to Wired. If this doesn't help, try running troubleshoot.py${NONE}"    
        read -r -p "Press Enter to continue to Main Menu"
    main_menu
}

scan_network_networkname () {
clear
check_eth0
check_iface
    if [ "$Mod" == "Monitor" ]; then
        sleep 0.1
    else
        echo -e "${LRED}This tool requires Monitor Mode${NONE}"
        read -r -p "Press Enter to return to Main Menu"
        main_menu
    fi
        scan_animation &
        
        trap 'airmon-ng stop $iface > /dev/null;rm otp-01.csv 2> /dev/null' EXIT
        airodump-ng --output-format csv -w otp "$iface" > /dev/null & sleep 10 ; kill $!
        sed -i '1d' otp-01.csv
        kill %1
        echo -e "\n\n${LRED}Scan Results${NONE}"
        cut -d "," -f 14 otp-01.csv | nl -n ln -w 6
    while [ "${S}" -gt "$(wc -l otp-01.csv | cut -d " " -f 1)" ] || [ "${S}" -lt 1 ]; do
        echo -e "\n${LBLUE}Select a Network"
        read -r -p "$(tput setaf 7) " S
    done
        nn=$(sed -n "${S}p" < otp-01.csv | cut -d "," -f 14 )
        rm -rf otp-01.csv 2> /dev/null
        echo -e "\n[${LGREEN}${nn}${NONE} ] Selected"
        read -r -p "$(tput setaf 7)Press Enter to Continue.."
    clear
    deauth
}

initial () {
selectnet

}

initial
