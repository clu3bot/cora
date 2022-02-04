import base64
import os
import time

def clear():
    os.system('cls' if os.name == 'nt' else 'clear')

def initial():
    clear()

    userinput = input("Encode/Decode base64: ")
    inputencode = userinput.encode("ascii")
  
    base64encode = base64.b64encode(inputencode)
    base64str = base64encode.decode("ascii")
  
    print("Encoded/Decoded string: "+base64str)
    return base64str

initial()

def ask():

    base64str = initial()
    clear()
    print (base64str)
    userchoice = input ("Save this string to a file? y/n")

    userchoicelower = userchoice.lower()
    if userchoicelower == 'y':
        os.system("echo "+base64str+" > backupstrs/base64str.txt")
        print ("File saved to cora/etc/crypto/backupstrs/")
    elif userchoicelower == 'n':
        time.sleep(1)
    else:
        print ("Invalid Option..")
        time.sleep(2)
        ask()

ask()

def last():
    clear()
    input ("Press any key to return to Crypto Menu..")

last()

