import os
import subprocess as sp
import time

def initial():
    global x
    x = sp.getoutput("cat scrp/inthandler/int.txt")

    global z
    if "mon" in x:
        z = 1
    else:
        z = 0

def second():
    global flag
    flag = "No such device"
    global flag2
    flag2 = "Mode"

    if z == 1:
        y = sp.getoutput("iwconfig "+x)
        if flag in y:
            xx = 1
            if xx == 1:
                os.system("sudo bash scrp/inthandler/namechangesedcommand.sh")
        elif flag2 in y:
            time.sleep(0.1)
    elif z == 0:

        yy = sp.getoutput("iwconfig "+x)
        if flag in yy:
            os.system("sudo python3 scrp/inthandler/namechangefunction.py")
    else:
        print ("Unexpected error.. Terminating")
        
    
def third():
    xxx = sp.getoutput("cat scrp/inthandler/int.txt")
    print (xxx)

def start():
    initial()
    second()
    third()

start()

