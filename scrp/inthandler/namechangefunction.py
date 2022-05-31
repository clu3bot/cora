import os 
import subprocess as sp

def initial():
    x = sp.getoutput("cat scrp/inthandler/int.txt")
    xx = x+"mon"
    os.system("rm -rf scrp/inthandler/int.txt")
    os.system("echo "+xx+" >scrp/inthandler/int.txt")

initial()