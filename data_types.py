two_digit_number = input("Type a two digit number: ")

#check the data type
print(type(two_digit_number))

#get the first and second digit by using subscripting then convert string to int
first_digit = int(two_digit_number[0])
second_digit = int(two_digit_number[1])

#add the two digits together
two_digit_number = first_digit + second_digit

print(two_digit_number)