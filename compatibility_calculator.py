#You are going to write a program that tests the compatibility between two people.  

#To work out the love score between two people:

#> Take both people's names and check for the number of times the letters in the word TRUE occurs. Then check for the number of times the letters in the word LOVE occurs. Then combine these numbers to make a 2 digit number. 
#For Love Scores **less than 10** or **greater than 90**, the message should be:
#`"Your score is **x**, you go together like coke and mentos."` 
#For Love Scores **between 40** and **50**, the message should be:

#`"Your score is **y**, you are alright together."`

#Otherwise, the message will just be their score. e.g.:

#`"Your score is **z**."`

name1 = "Angela Yu"
name2 = "Jack Bauer"

combined_string = name1 + name2

lowercase_string = combined_string.lower()

t = lowercase_string.count("t")
r = lowercase_string.count("r")
u = lowercase_string.count("u")
e = lowercase_string.count("e")

true = t + r + u + e 

l = lowercase_string.count("l")
o = lowercase_string.count("o")
v = lowercase_string.count("v")
e = lowercase_string.count("e")

love = l + o + v + e 

love_score = int(str(true) + str(love))
int_love_score = int(love_score)
#this being a string will cause issues when we go to compare b/c pyhon will not let you compare strings like this, you'll get this error: TypeError: '<' not supported between instances of 'str' and 'int'
#to fix this you can do either of 2 things. love_score = int(str(true) + str(love)) or create another variable, int_love_score = int(love_score)

if love_score < 10 or love_score > 90:
    print(f"Your score is {love_score}, you go together like coke and mentos.")
elif love_score >= 40 and love_score <= 50:
    print(f"Your score is {love_score}, you are alright together.")
else:
    print(f"Your score is {love_score}.")