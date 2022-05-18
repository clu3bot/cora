import os 
import subprocess as sp

def initial():
    x = sp.getoutput("cat int.txt")
    xx = x+"mon"
    os.system("rm -rf int.txt")
    os.system("echo "+xx+" >int.txt")

initial()