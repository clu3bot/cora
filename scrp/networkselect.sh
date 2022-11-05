#!/bin/bash/
#var
value=1000
int=$(sudo python3 scrp/inthandler/rename.py)

command(){
    airodump-ng --output-format csv -w otp "$int" > /dev/null & sleep 10 ; kill $! 
}

main(){
clear       
    #failsafe for exit
    trap 'airmon-ng stop $int > /dev/null;rm otp-01.csv 2> /dev/null' EXIT
    command
    sed -i '1d' otp-01.csv
    kill %1
    clear
    echo -e "\n\n${LRED}Scan Results${NONE}"
    cut -d "," -f 14 otp-01.csv | nl -n ln -w 6
        while [ ${value} -gt "$(wc -l otp-01.csv | cut -d " " -f 1)" ] || [ ${value} -lt 1 ]; do
            echo -e "\n${LBLUE}Select a Network"
            read -r -p "$(tput setaf 7)" value
        done
    essid=$(sed -n "${value}p" < otp-01.csv | cut -d "," -f 14 )
    rm -rf otp-01.csv 2> /dev/null
    echo -e "\n[${LGREEN}${essid}${NONE} ] Selected"
    echo $essid > /tmp/essid.txt
    read -r -p "$(tput setaf 7)Press Enter to Continue.."
        clear

    exit
}

initial(){
    main
}

initial
