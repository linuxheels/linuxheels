#how to find the highest scores in a list

student_scores = input("Input a list of student scores").split()
for n in range(0, len(student_scores)):
    student_scores[n] = int(student_scores[n])
print(student_scores)

[56, 89, 99, 51, 28, 47]

highest_score = 0
for score in student_scores:
    if score > highest_score:
        highest_score = score 

print(f"The Highest score in the class is: {highest_score}")


#example of what is going on here if you're confused....... The highest_score variable is set to 0 at the beginning, as the for loop runs it checks each integer (known as score) to see if it is > than my variable highest_score and if so it will update that value. So when this loop 
#first runs it picks the number 56 and compares it to highest_score which is at 0 so that would be TRUE and change the value to 56, then it runs again for each score and either updates the value or skips it if it less than the current value. 