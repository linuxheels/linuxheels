eyecolors = ['blue', 'green', 'brown', 'hazel']

for colors in eyecolors:
    print (colors)


def function(device):

    for key, value in device.items():
        print (key,value)

device = {
    "name": "tdchost",
    "vendor": "cisco",
    "node1": "nexus9k Chassis",
    "os": "nxos",
    "version": "9.3",
    "ip": "10.10.10.10",
    }

function(device)