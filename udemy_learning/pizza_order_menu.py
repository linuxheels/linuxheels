#Small Pizza: $15
#Medium Pizza: $20
#Large Pizza: $25
#pepporoni for small pizza: +$2
#pepporoni for med or large pizza: +$3
#extra cheese for any size pizza: +$1


print("Welcome to Python Pizza Deliveries")
size = input("What size pizza do you want? S, M. or L? ")
add_pepperoni = input("Do you want peporroni? Y or N ")
extra_cheese = input("Do you want extra cheese? Y or N ")
bill = 0

if size == "S":
    bill += 15
    if add_pepperoni == "Y":
        bill += 2
    if extra_cheese == "Y":
        bill += 1
    print(f"Your total bill is ${bill}")
elif size == "M":
    bill += 20
    if add_pepperoni == "Y":
        bill += 3
    if extra_cheese == "Y":
        bill += 1
    print(f"Your total bill is ${bill}")
else:
    bill += 25
    if add_pepperoni == "Y":
        bill += 3
    if extra_cheese == "Y":
        bill += 1
    print(f"Your total bill is ${bill}")