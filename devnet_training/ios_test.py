from netmiko import ConnectHandler

iosv_12 = {
    'device_type': 'cisco_ios',
    'ip': '131.226.217.143',
    'username': 'developer',
    'password': 'C1sco12345',
}

net_connect = ConnectHandler(**iosv_12)
output = net_connect.send_command('show ip int brief')
print(output)