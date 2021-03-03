from pprint import pprint

device = {
    "name": "tdchost",
    "vendor": "cisco",
    "node1": "nexus9k Chassis",
    "os": "nxos",
    "version": "9.3",
    "ip": "10.10.10.10",
}

print("device name", device["name"])


# for loop stuff
print ("\n_______FOR LOOP,_______")
for key, value in device.items():
    print (key,value)

# for loop stuff
print ("\n_______FOR LOOP,_______")
for key, value in device.items():
    print(f"{key:>16s}:{value}")
