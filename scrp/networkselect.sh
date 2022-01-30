#!/bin/bash/

check_iface() {
    iface=$(cat scrp/tmp/int.txt)

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

main(){
clear
    check_iface
        if [ "$Mod" == "Monitor" ]; then
            sleep 0.1
        else
            echo -e "${LRED}This tool requires Monitor Mode${NONE}"
            read -r -p "Press Enter to return to Main Menu"
                main_menu
        fi
    scan_animation &
        #failsafe for exit
        trap 'airmon-ng stop $iface > /dev/null;rm otp-01.csv 2> /dev/null' EXIT
            xterm -e airodump-ng --output-format csv -w otp "$iface" > /dev/null & sleep 10 ; kill $!
            sed -i '1d' otp-01.csv
        kill %1
    echo -e "\n\n${LRED}Scan Results${NONE}"
        cut -d "," -f 14 otp-01.csv | nl -n ln -w 6
            while [ ${S} -gt "$(wc -l otp-01.csv | cut -d " " -f 1)" ] || [ ${S} -lt 1 ]; do
                echo -e "\n${LBLUE}Select a Network"
                read -r -p "$(tput setaf 7) " S
            done
        nn=$(sed -n "${S}p" < otp-01.csv | cut -d "," -f 14 )
        rm -rf otp-01.csv 2> /dev/null
    echo -e "\n[${LGREEN}${nn}${NONE} ] Selected"
    read -r -p "$(tput setaf 7)Press Enter to Continue.."
        clear
        main_menu
}

initial(){
    main
}

initial
