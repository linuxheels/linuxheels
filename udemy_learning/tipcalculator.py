print("Welcome to the tip calculator.")
total_bill = input("What was the total bill?")
tip = input("What percentage tip would you like to give? 10, 12, or 15?")
people_splitting = input("How many people to split the bill?")

each = (float(total_bill) * float(1.12) / int(people_splitting))
each_rounded = round(each, 2)

print(f"Each person should pay: ${each_rounded}")