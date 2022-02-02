import os 
import subprocess as sp
import time
import platform


def clear(): #clear
    os.system('cls' if os.name == 'nt' else 'clear')

def downloads(): #checks if downloads has been run.
    check = sp.getoutput("cat etc/done_flag.txt")

    if check == 'done':
        time.sleep(1)
    else:
        flag_downloads = 0
        return flag_downloads

def permissions():  #checks for root permissions
    if not os.environ.get("SUDO_UID") and os.geteuid() != 0:
        flag_permissions = 0
    else:
        time.sleep(1)

def getos(): # checks if system is linux
    osys=platform.system()
    if osys != "Linux":
        flag_os = 0
    else:
        time.sleep(1)

