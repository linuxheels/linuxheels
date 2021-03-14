
#https://docs.python.org/3/tutorial/datastructures.html

states_of_america = ["NC", "SC", "TN", "FL", "VA", "PA"]
#states_of_america.clear() # this will clear your list out to nothing
#states_of_america.append("KY")    #to add a new item to the list
#states_of_america.extend(["AZ", "CA", "NM", "TX", "AL", "AL"])

#states_of_america.insert(0, "WV")    #TO INSERT AN ITEM AT A CERTAIN POSITION IN THE LIST#

# to change an item in the list.
#states_of_america[0] = "CN"     #this will change NC to CN
if states_of_america.count("TX") == 0:
   print(states_of_america)
else:
    print("this country needs a TX!")