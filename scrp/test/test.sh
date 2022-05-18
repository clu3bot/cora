#!/bin/bash
#colors vars
LBLUE='\033[1;34m'
LRED='\033[1;31m'
LGREEN='\033[1;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NONE='\033[0m'
PURPLE='\033[1;35m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
#

var=1000

end(){
        echo -e "\n${NONE}[${LGREEN}${int}${NONE}] Selected"
        read -r -p "$(tput setaf 7)Press Enter to Continue.."
        rm -rf wifiifaces.csv
        echo "$int" > int.txt
}

notvalid(){
        clear
        unset $int
                echo -e "${LRED}Your selection was not valid"
                int="An Error has occured with your Interface"
        sleep 3
end
}

valid(){
        rm -rf var.txt
                clear
        sleep 0.5
end
}

inputvalidation(){
        if echo $int | grep -E '[ "]' >/dev/null
        then
                notvalid
        else
                valid
        fi
}

output(){
        unset $int
                clear
                        echo -e "Select an Interface:\n"
                        iwconfig 2>&1 | grep -oP "^\w+" > wifiifaces.csv
                        ##
                                cut -d "," -f 14 wifiifaces.csv | nl -n ln -w 6
                                while [ ${var} -gt "$(wc -l wifiifaces.csv | cut -d " " -f 1)" ] || [ ${var}} -lt 1 ]; do
                        echo -e "\nSelect a Network"
                        read -r -p "$(tput setaf 7)" var
                                done
                int=$(sed -n "${var}p" < wifiifaces.csv | cut -d "," -f 14 )
                rm -rf wifiifaces.csv
                clear
}
output
inputvalidation