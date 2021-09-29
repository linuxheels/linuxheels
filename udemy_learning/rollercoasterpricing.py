print("Welcome to the rollercoaster!")
height = int(input("What is your height in ft? "))
bill = 0

if height >= 5:
    print("You can ride this rollercoaster")
    age = int(input("What is your age? "))
    if age <= 12:
      bill = 5  
      print("Child tickets are $5.00")
    elif age <= 18:
      bill = 7  
      print("Youth tickets are $7.00")
    else:
      bill = 12  
      print("Adult tickets are $12.00")

    wants_photo = input("Do you want a photo taken? Y or N? ")
    if wants_photo == "Y":
       bill += 3
    print(f"Your final bill is ${bill}")
else:
     print("You can not ride this rollercoaster")