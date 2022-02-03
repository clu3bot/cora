import base64


#encode and decode with base64
def initial():
  
    userinput = input("Encode/Decode base64: ")
    inputencode = userinput.encode("ascii")
  
    base64encode = base64.b64encode(inputencode)
    base64str = base64encode.decode("ascii")
  
    print("Encoded/Decoded string: "+base64str)

initial()