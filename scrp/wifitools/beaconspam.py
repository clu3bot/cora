import os
import time
import subprocess as sp

def randomnames():
    time.sleep(1)

def namesfile():
    time.sleep(1)

def beaconspam():
    print ("Beacon Flood Options:\n\n")
    print ("[1] Use Random Names")
    print ("[2] Use a Names File")
    i = input ("\n\nChoose an Option: ")

    if i == "1":
        randomnames()
    elif i == "2":
        namesfile()
    else:
        print ("Invalid Option")

beaconspam()
