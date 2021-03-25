#examples
#days * hours * minutes
#print(f"20 days are {20 * 24 * 60} minutes")
#print(f"35 days are {35 * 24 * 60} minutes")
#print(f"50 days are {50 * 24 * 60} minutes")

#days
print(f" 1 hour is {1 * 60 * 60} seconds")
print(f" 1 day is {1 * 24 * 60 * 60} seconds")
print(f" 20 days is {20 * 24 * 60 * 60} seconds")

type_of_calculation = input("What do you want to calculate? Enter seconds or minutes?\n")

if type_of_calculation == "minutes":
  minute = int(input("What minutes do you want to calculate?"))
  if minute == 20:
   print(f"20 days are {20 * 24 * 60} minutes")