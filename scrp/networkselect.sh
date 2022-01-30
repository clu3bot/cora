#!/bin/bash/
#var
value=1000

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
                exit
        fi
        #failsafe for exit
        trap 'airmon-ng stop $iface > /dev/null;rm otp-01.csv 2> /dev/null' EXIT
            xterm -e airodump-ng --output-format csv -w otp "$iface" > /dev/null & sleep 10 ; kill $!
            sed -i '1d' otp-01.csv
        kill %1
    echo -e "\n\n${LRED}Scan Results${NONE}"
        cut -d "," -f 14 otp-01.csv | nl -n ln -w 6
            while [ ${value} -gt "$(wc -l otp-01.csv | cut -d " " -f 1)" ] || [ ${value} -lt 1 ]; do
                echo -e "\n${LBLUE}Select a Network"
                read -r -p "$(tput setaf 7) " value
            done
        essid=$(sed -n "${value}p" < otp-01.csv | cut -d "," -f 14 )
        rm -rf otp-01.csv 2> /dev/null
    echo -e "\n[${LGREEN}${essid}${NONE} ] Selected"
    echo $essid > scrp/tmp/essid.txt
    read -r -p "$(tput setaf 7)Press Enter to Continue.."
        clear
        exit
}

initial(){
    main
}

initial
