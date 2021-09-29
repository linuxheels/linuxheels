#Write a program that works out whether if a givne year is a leap year. A normal year has 365 days, a leap year will have 366 days, with an extra day in february. 
#Leap year rules
# on every year that is evenly divisible by 4
# except if the year is evenly divisible by 100
# unless the year is also evenly divisible by 400
# so it has to be divisible by 4, if not it's not a leap year, but if it is divisible by 4 but not 100 it is a leap year, BUT!!!!!!!!if it can be divisible by 100 then it must also be divisible by 400 otherwise it is not a leap year.

year = int(input("Which year do you want to check "))

if year % 4 == 0:
    if year % 100 == 0:
     if year % 400 == 0:
        print(f"{year} is a leap year")
     else:
        print(f"{year} is not a leap year")    
    else:
        print(f"{year} is a leap year")
else:
  print(f"{year} is not a leap year")

