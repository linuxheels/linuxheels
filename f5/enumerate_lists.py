names = ["mike", "misty", "savannah", "logan", "kenzie"]

for name in range(len(names)):
    print(name, names[name])


for idx, name in enumerate(names):
    print(idx, name)

#this is will start you count at 1 instead of the default 0
for idx, name in enumerate(names, start=1):
    print(idx, name)