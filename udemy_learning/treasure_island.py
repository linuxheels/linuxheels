print('''        
 _                                     _     _                 _ 
| |                                   (_)   | |               | |
| |_ _ __ ___  __ _ ___ _   _ _ __ ___ _ ___| | __ _ _ __   __| |
| __| '__/ _ \/ _` / __| | | | '__/ _ \ / __| |/ _` | '_ \ / _` |
| |_| | |  __/ (_| \__ \ |_| | | |  __/ \__ \ | (_| | | | | (_| |
 \__|_|  \___|\__,_|___/\__,_|_|  \___|_|___/_|\__,_|_| |_|\__,_|
''')



print("Welcome to Treasure Island.\n"  "Your mission is to find the treasure, choose wisely")
direction = input("You are at a crucial point in the game. Which way do you want to go? Type 'left' or 'right'\n")
#swim_or_walk = input("Would you like to swim or walk?\n")
#door_color = input("Which color door would you like to walk through? red, blue, or yellow?\n")




if direction == "left":
  swim_or_wait = input('Congrats you have made it to the middle of the lake. Type "wait" to wait for a boat or type "swim" to swim across?\n').lower()
  if swim_or_wait == "wait":
    door_color = input("Which color door would you like to walk through? red, blue, or yellow?\n").lower()
    if door_color == "red":
         print("You entered a room on fire, GAME OVER!")
    elif door_color == "yellow":
         print("You win!")
    elif door_color == "blue":
         print("You entered a room full of hungry beasts, GAME OVER!")
    else:
         print("You chose a door color that doesn't exist, GAME OVER!")  
  else:
    print("You got attacked by a pack of angy gators, GAME OVER!")
else:
   print("Game Over!")  