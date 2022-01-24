#!/usr/bin/env bash

#colors
#bold="(tput bold)"
magenta="\033[1;35m"
green="\033[1;32m"
white="\033[1;37m"
blue="\033[1;34m"
red="\033[1;31m"
black="\033[1;40;30m"
yellow="\033[1;33m"
cyan="\033[1;36m"
reset="\033[0m"
bgyellow="\033[1;43;33m"
bgwhite="\033[1;47;37m"
c0="${reset}"
c1="${magenta}"
c2="${green}"
c3="${white}"
c4="${blue}"
c5="${red}"
c6="${yellow}"
c7="${cyan}"
c8="${black}"
c9="${bgyellow}"
c10="${bgwhite}"

#getting the init
get_init() {
    os="$(uname -o)"
    if [[ "$os" = "Android" ]]; then
       echo "init.rc"
    elif [[ ! $(pidof systemd) ]]; then
        if [[ -f "/sbin/openrc" ]]; then
            echo "openrc"
        else
         echo $(cat /proc/1/comm)
        fi
    else
        echo "systemD"
    fi
}

#get total packages
net_pkg() {
    pack="$(which {xbps-install,apk,apt,pacman,nix,yum,rpm,dpkg,emerge} 2>/dev/null | grep -v "not found" | awk -F/ 'NR==1{print $NF}')"
  case "${pack}" in
      "xbps-install")
	 total=$(xbps-query -l | wc -l)
	 ;;
      "apk")
	 total=$(apk search | wc -l)
	 ;;
      "apt")
	 total=$(apt list --installed 2>/dev/null | wc -l)
	 ;;
      "pacman")
	 total=$(pacman -Q | wc -l)
	 ;;
      "nix")
	 total=$(nix-env -qa --installed "*" | wc -l)
	 ;;
      "yum")
	 total=$(yum list installed | wc -l)
	 ;;
      "rpm")
	 total=$(rpm -qa | wc -l)
	 ;;
      "emerge")
	 total=$(qlist -I | wc -l)
	 ;;
#      "dpkg")
#	 total=$(dpkg-query -l | wc -l)
#	 ;;
      "")
	 total="Unknown"
	 ;;
  esac

  echo $total
}

# check distro info for counting n.o of packages accordingly
distro_detect() {
    os="$(uname -o)"
    case "${os}" in
	Android)
	   distro="Android"
	   if [ ! -f "${HOME}"/.termux/fonts/Material.ttf ];then
		cp fonts/* "${HOME}"/.termux/fonts/
		termux-reload-settings
	   fi
	   ;;
	*)
	   distro="$(source /etc/os-release && echo "${PRETTY_NAME}")"
       if [ ! -d $HOME/.local/share/fonts ]; then
        mkdir -p $HOME/.local/share/fonts
       fi
	   if [ ! -f $HOME/.local/share/fonts/Material.ttf ] && [ ! -f /usr/share/fonts/Material.ttf ]; then
		cp -r ttf-material-design-icons/* $HOME/.local/share/fonts
		fc-cache -vf &>/dev/null
	   fi
	   ;;
    esac
}

storage_info() {
    storageused=$(df -h / | grep "/" | awk '{print $3}')
    storageavail=$(df -h / | grep "/" | awk '{print $2}')
}

# Get Memory usage
get_mem () {
  free --mega | sed -n -E '2s/^[^0-9]*([0-9]+) *([0-9]+).*/'"${space}"'\2 \/ \1 MB/p'
}
# fetch output
distro_detect
storage_info
echo "               "
echo -e "               ${c1}os${c3}    ${distro} $(uname -m)"
echo -e "      ${c3}•${c8}_${c3}•${c0}      ${c2}ker${c3}   $(uname -r)"
echo -e "      ${c8}${c0}${c9}oo${c0}${c8}|${c0}      ${c7}pkgs${c3}  $(net_pkg)"
echo -e "     ${c8}/${c0}${c10} ${c0}${c8}'\'${c0}     ${c4}sh${c3}    $(basename "${SHELL}")"
echo -e "    ${c9}(${c0}${c8}\_;/${c0}${c9})${c0}     ${c6}ram${c3}   $(get_mem)"
echo -e "               ${c1}init${c3}  $(get_init)"
echo -e "               ${c7}up${c3}   $(uptime -p | sed 's/up//')"
echo -e "               ${c4}disk${c3}  $storageused / $storageavail"
echo -e "               "
echo -e "        ${c6}󰮯  ${c6}${c2}󰊠  ${c2}${c4}󰊠  ${c4}${c5}󰊠  ${c5}${c7}󰊠  ${c7}"
echo -e "               \033[0m"