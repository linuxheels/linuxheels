# Split string method
import random

names_string = input("Give me everybody's names, separated by a comma. ")
names = names_string.split(", ")
#print(type(names))
#number_of_names = len(names)

#random_name = random.randint(0, number_of_names - 1)
#person_who_will_pay = names[random_name]

####OR YOU COULD SKIP ALL THESE VARIABLES AND JUST USE THIS BELOW TO CREATE A RANDOM CHOISE FROM THE LIST
person_who_will_pay = random.choice(names)
print(f"{person_who_will_pay} Dinner is on you today!")