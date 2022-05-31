import os
import subprocess as sp 

def getinterface():
    global interface
    if os.path.isfile("scrp/inthandler/int.txt"):
        interface = sp.getoutput("sudo python3 scrp/inthandler/rename.py")    
    else:
        interface = "No Interface Selected"
        time.sleep(0.1)

def checkvar():
    handlenamechange()
    if interfacecurrent == 'No Interface Selected':
        print ("Cannot continue no interface selected..")
        time.sleep(1)
        print ("Returning to Main Menu..")
        time.sleep(2)
    else:
        time.sleep(0.1) 

def selectint():
    os.system("sudo bash scrp/inthandler/selectint.sh")
    getinterface()

def showmode():
    os.system("sudo bash scrp/inthandler/namechange1.sh")

def initial():
    getinterface()
    print (interface)
    showmode()

initial()