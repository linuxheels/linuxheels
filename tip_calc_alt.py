#print("Welcome to the tip calculator.")
#total_bill = input("What was the total bill?")
#tip = input("What percentage tip would you like to give? 10, 12, or 15?")
#people_splitting = input("How many people to split the bill?")

#each = (float(total_bill) * float(1.12) / int(people_splitting))
#each_rounded = round(each, 2)

#print(f"Each person should pay: ${each_rounded}")

######################################################################################OR HERE'S A DIFFERENT WAY TO GET THE SAME RESULT

print("Welcome to the tip calculator!")
bill = float(input("What was the total bill? $"))
tip = int(input("How much tip would you like to give? 10, 12, 15, custom? "))
people_splitting = int(input("How many people to split the bill?"))

tip_as_percent = tip / 100
total_tip_amount = bill * tip_as_percent
total_bill = bill + total_tip_amount
each = total_bill / people_splitting
#each_rounded = round(each, 2)
#This is useful to address the way in which python formulates the final amount and will not show a zero in the second place digit. 
each_rounded = "{:.2f}".format(each)
#print("Each person should pay ")

print(f"Each person should pay: ${each_rounded}")
#print("{:.2f}".format(each_rounded)) 