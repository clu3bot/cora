alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

input_str = input("Enter message that you would like to encrypt/decrypt: ")
value = input_str.upper()
shift = 13
no_of_itr = len(value)
output_str = ""

for i in range(no_of_itr):
    current = value[i]
    location = alphabets.find(current)
    if location < 0:
        output_str += value[i]
    else:
        new_location = (location + shift)%26
        output_str += alphabets[new_location]

new_output = output_str.lower()

print ("Output: "+new_output)
