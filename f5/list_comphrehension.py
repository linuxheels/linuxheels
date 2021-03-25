#list_of_colors = ["blue", "aqua", "green", "black", "burple", "orange", "burnt_orange", "violet"]

#copy_list_of_colors = []

#named_list = [action for an item in my_list]
#named_list became copy_list_of_colors and action became color and we put in the for loop from earlier as well, and get the same results
#copy_list_of_colors = [color for color in list_of_colors]

#print(copy_list_of_colors)

#print(f"These are the items in 'copy_list_of_colors' BEFORE the for loop: \n \n {copy_list_of_colors}")

#for color in list_of_colors:
    #copy_list_of_colors.append(color)

#print(f"These are the items in 'copy_list_of_colors' AFTER the for loop: \n \n {copy_list_of_colors}")


#exact copies are boring so let's do some other stuff as well


list_of_colors = ["blue", "aqua", "green", "black", "burple", "orange", "burnt_orange", "violet"]

short_list_of_colors = []

for color in list_of_colors:
    if "b" in color:
        short_list_of_colors.append(color)
print(short_list_of_colors)

#LIST COMPREHENSION ON THIS WOULD BE:
#short_list_of_colors = [color for color in list_of_colors if "b" in color]

copy_list_of_colors = [color for color in list_of_colors]

print(short_list_of_colors)