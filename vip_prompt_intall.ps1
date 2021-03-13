add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Ssl3, [Net.SecurityProtocolType]::Tls, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls12

###############################################################IMPORTANT NOTES & DEFAULT VALUES##########################################################
#script written by Michael Massey
#Contributers: David Edmonds, Ledell Lucky, Kiva Thompkins, Nick Patek, Corey Brewer, Bill "The Thrill" Eddins

#persistname = This will be collected as part of the url variable
#cookiename =  This will be collected as part of the url variable
#cookie_parent profile = When prompted for persist type the parent profile will be added automatically for now, more options in future development.
#monitor profile = Using bbt-generic-tcp-monitor for layer 4 or bbt-generic-http-monitor for layer 7 monitors for now, more options in future development"
#$monitorname = This will be collected as part of the url variable for layer 7 example monitor.bbtnet.com-http, layer 4 will be defaulted to bbt-generic-tcp-monitor if selected during monitor type question"

############################################################### END OF IMPORTANT NOTES & DEFAULT VALUES####################################################

################################################################START OF VARIABLE SECTION##################################################################

$f5ip = Read-Host "Enter Active F5"
$tenant = Read-Host "Enter Tenant"
$url = Read-Host "Enter URL"
#$url-persist = "$url-persist"
$vip = Read-Host "Enter VIP"
$vip_port = Read-Host "Enter VIP Listerner Port"
$vip_description = Read-Host "Enter VIP Description"
$appid = Read-Host "Enter App ID"
$snat_pool = Read-Host "Enter SNAT POOL"
$irule_required = Read-Host "Enter Number of iRules Required"
$persist_type = Read-Host "Enter persist type (either cookie or source_ip)"
#DO NOT EDIT BETWEEN THESE LINES, THIS IS LOGIC FOR PERSISTENT PROFILES
if ($persist_type -eq "cookie")
{
$persist_name = "$url-persist"
}
if ($persist_type -eq "source_ip")
{
$persist_name = "$url-sticky-srcip_32"
}
#DO NOT EDIT ABOVE BETWEEN THESE LINES,  THIS IS LOGIC FOR PERSISTENT PROFILES

$node_status = Read-Host "Do servers already exist in pool? If not type N, If yes type Y"
$servers_required = Read-Host "How many servers are required?"
$monitortype = Read-Host "If layer 7 monitor type 7, If layer 4 type 4"
$http_https = Read-Host "If layer 7, is monitor http or https?"
$pool_port = Read-Host "Enter pool listening port number"
if ($monitortype -eq 4)
{
$monitorname = "bbt-generic-tcp-monitor"
}
#N 
if ($monitortype -eq 7 -and $http_https -eq "http")
{
$monitorname = "$url-http"
$sendstring = Read-Host "Enter Send String ***DO NOT INCLUDE the following HTTP/1.1\\r\\nHost: \\r\\nConnection: Close\\r\\n\\r\\n"
$recvstring = Read-Host "Enter Receive String"
}
if ($monitortype -eq 7 -and $http_https -eq "https")
{
$monitorname = "$url-https"
$sendstring = Read-Host "Enter Send String ***DO NOT INCLUDE the following HTTP/1.1\\r\\nHost: \\r\\nConnection: Close\\r\\n\\r\\n"
$recvstring = Read-Host "Enter Receive String"
}


###############IRULE LOGIC########################
if ($irule_required -eq 1)
{
$irule1 = "bbt-generic-irule-xff-ip-port"
}
if ($irule_required -eq 2)
{
$irule1 = Read-Host "1st irule name"
$irule2 = Read-Host "2nd irule name"
}
if ($irule_required -eq 3)
{
$irule1 = Read-Host "1st irule name"
$irule2 = Read-Host "2nd irule name"
$irule3 = Read-Host "3rd irule name"
}
if ($irule_required -eq 4)
{
$irule1 = Read-Host "1st irule name"
$irule2 = Read-Host "2nd irule name"
$irule3 = Read-Host "3rd irule name"
$irule4 = Read-Host "4th irule name"
}
###############END OF IRULE LOGIC########################


###############NEW  NODE LOGIC########################

if ($node_status -eq "N" -and $servers_required -eq 1)
{
$nodename1 = Read-Host "Enter Node 1"
$newnode1ip = Read-Host "Enter IP address of pool member"
}
if ($node_status -eq "N" -and $servers_required -eq 2)
{
$nodename1 = Read-Host "Enter New Node 1"
$newnode1ip = Read-Host "Enter IP address of pool member"
$nodename2 = Read-Host "Enter New Node 2"
$newnode2ip = Read-Host "Enter IP address of pool member"
}
if ($node_status -eq "N" -and $servers_required -eq 3)
{
$nodename1 = Read-Host "Enter New Node 1"
$newnode1ip = Read-Host "Enter IP address of pool member"
$nodename2 = Read-Host "Enter New Node 2"
$newnode2ip = Read-Host "Enter IP address of pool member"
$nodename3 = Read-Host "Enter New Node 3"
$newnode3ip = Read-Host "Enter IP address of pool member"
}
if ($node_status -eq "N" -and $servers_required -eq 4)
{
$nodename1 = Read-Host "Enter New Node 1"
$newnode1ip = Read-Host "Enter IP address of pool member"
$nodename2 = Read-Host "Enter New Node 2"
$newnode2ip = Read-Host "Enter IP address of pool member"
$nodename3 = Read-Host "Enter New Node 3"
$newnode3ip = Read-Host "Enter IP address of pool member"
$nodename4 = Read-Host "Enter New Node 4"
$newnode4ip = Read-Host "Enter IP address of pool member"
}
#####End new nodes#######


###############END OF NEW  NODE LOGIC########################

###############EXISTING NODE LOGIC########################

if ($node_status -eq "Y" -and $servers_required -eq 1)
{
$nodename1 = Read-Host "Enter Node 1"
}
if ($node_status -eq "Y" -and $servers_required -eq 2)
{
$nodename1 = Read-Host "Enter Node 1"
$nodename2 = Read-Host "Enter Node 2"
}
if ($node_status -eq "Y" -and $servers_required -eq 3)
{
$nodename1 = Read-Host "Enter Node 1"
$nodename2 = Read-Host "Enter Node 2"
$nodename3 = Read-Host "Enter Node 3"
}
if ($node_status -eq "Y" -and $servers_required -eq 4)
{
$nodename1 = Read-Host "Enter Node 1"
$nodename2 = Read-Host "Enter Node 2"
$nodename3 = Read-Host "Enter Node 3"
$nodename4 = Read-Host "Enter Node 4"
}
if ($node_status -eq "Y" -and $servers_required -eq 5)
{
$nodename1 = Read-Host "Enter Node 1"
$nodename2 = Read-Host "Enter Node 2"
$nodename3 = Read-Host "Enter Node 3"
$nodename4 = Read-Host "Enter Node 4"
$nodename4 = Read-Host "Enter Node 5"
}
if ($node_status -eq "Y" -and $servers_required -eq 6)
{
$nodename1 = Read-Host "Enter Node 1"
$nodename2 = Read-Host "Enter Node 2"
$nodename3 = Read-Host "Enter Node 3"
$nodename4 = Read-Host "Enter Node 4"
$nodename4 = Read-Host "Enter Node 5"
$nodename4 = Read-Host "Enter Node 6"
}
if ($node_status -eq "Y" -and $servers_required -eq 7)
{
$nodename1 = Read-Host "Enter Node 1"
$nodename2 = Read-Host "Enter Node 2"
$nodename3 = Read-Host "Enter Node 3"
$nodename4 = Read-Host "Enter Node 4"
$nodename4 = Read-Host "Enter Node 5"
$nodename4 = Read-Host "Enter Node 6"
$nodename4 = Read-Host "Enter Node 7"
}
if ($node_status -eq "Y" -and $servers_required -eq 8)
{
$nodename1 = Read-Host "Enter Node 1"
$nodename2 = Read-Host "Enter Node 2"
$nodename3 = Read-Host "Enter Node 3"
$nodename4 = Read-Host "Enter Node 4"
$nodename4 = Read-Host "Enter Node 5"
$nodename4 = Read-Host "Enter Node 6"
$nodename4 = Read-Host "Enter Node 7"
$nodename4 = Read-Host "Enter Node 8"
}
if ($node_status -eq "Y" -and $servers_required -eq 9)
{
$nodename1 = Read-Host "Enter Node 1"
$nodename2 = Read-Host "Enter Node 2"
$nodename3 = Read-Host "Enter Node 3"
$nodename4 = Read-Host "Enter Node 4"
$nodename4 = Read-Host "Enter Node 5"
$nodename4 = Read-Host "Enter Node 6"
$nodename4 = Read-Host "Enter Node 7"
$nodename4 = Read-Host "Enter Node 8"
$nodename4 = Read-Host "Enter Node 9"
}
if ($node_status -eq "Y" -and $servers_required -eq 10)
{
$nodename1 = Read-Host "Enter Node 1"
$nodename2 = Read-Host "Enter Node 2"
$nodename3 = Read-Host "Enter Node 3"
$nodename4 = Read-Host "Enter Node 4"
$nodename4 = Read-Host "Enter Node 5"
$nodename4 = Read-Host "Enter Node 6"
$nodename4 = Read-Host "Enter Node 7"
$nodename4 = Read-Host "Enter Node 8"
$nodename4 = Read-Host "Enter Node 9"
$nodename4 = Read-Host "Enter Node 10"
}

###############END OF EXISTING NODE LOGIC########################

################################################################END OF VARIABLE SECTION###################################################################

################################################################START OF CREDENTIAL SECTION###################################################################

$c = Get-Credential
$un = $c.GetNetworkCredential().UserName
$pn = $c.GetNetworkCredential().Password


$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")


$body = "{
`n`"username`":`"$un`",
`n
`n`"password`":`"$pn`",
`n
`n`"loginProviderName`": `"tmos`"
`n
`n
`n}"
write-host "https://$f5ip/mgmt/shared/authn/login" -Method 'POST' -Headers $headers -Body $body
$response = Invoke-RestMethod "https://$f5ip/mgmt/shared/authn/login" -Method 'POST' -Headers $headers -Body $body
$token = $response.token.token 
$response | ConvertTo-Json 

################################################################END OF CREDENTIAL SECTION###################################################################


################################################################START OF PERSIST SECTION###################################################################
<#
if ($persist_type -eq "cookie")
#if ($cookie_pp_default -eq "cookie")
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{
`n	`"name`": `"$url-persist`",
`n	`"defaultsFrom`": `"/Common/cookie`",
`n    `"cookieName`": `"netcookie-$url`"
`n	}"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/persistence/cookie" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json

}
#>

if ($persist_type -eq "cookie")
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{
`n	`"name`": `"$persist_name`",
`n	`"defaultsFrom`": `"/Common/bbt-generic-cookie-insert`",
`n    `"cookieName`": `"netcookie-$url`"
`n	}"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/persistence/cookie" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
}
if ($persist_type -eq "source_ip")
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{
`n	`"name`": `"$persist_name`",
`n	`"defaultsFrom`": `"/Common/bbt-generic-source-ip`"
`n	}"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/persistence/source-addr" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
}

################################################################END OF PERSIST SECTION###################################################################



################################################################START OF MONITOR SECTION###################################################################

if ($monitortype -eq 4)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{
`n            `"name`": `"$monitorname`",
`n            `"partition`": `"Common`",
`n			`"defaultsFrom`": `"/Common/tcp`",
`n			`"description`": `"`"
`n			}"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/monitor/tcp" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
}

if ($monitortype -eq 7 -and $http_https -eq "http")
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{
`n            `"name`": `"$monitorname`",
`n            `"partition`": `"Common`",
`n			`"defaultsFrom`": `"/Common/bbt-generic-http-monitor`",
`n			`"description`": `"`",
`n			`"send`": `"$sendstring HTTP/1.1\\r\\nHost: \\r\\nConnection: Close\\r\\n\\r\\n`",
`n			`"recv`": `"$recvstring`"
`n			}"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/monitor/http" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
}
if ($monitortype -eq 7 -and $http_https -eq "https")
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{
`n            `"name`": `"$monitorname`",
`n            `"partition`": `"Common`",
`n			`"defaultsFrom`": `"/Common/https`",
`n			`"description`": `"`",
`n			`"send`": `"$sendstring HTTP/1.1\\r\\nHost: \\r\\nConnection: Close\\r\\n\\r\\n`",
`n			`"recv`": `"$recvstring`"
`n			}"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/monitor/https" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
}


################################################################END OF MONITOR SECTION##################################################################

################################################################START OF NEW NODE SECTION###############################################################

if ($node_status -eq "N" -and $servers_required -eq 1)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{
`n	`"name`":`"$nodename1`",
`n    `"partition`":`"$tenant`",
`n    `"address`":`"$newnode1ip`"
`n}"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/node" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
}

if ($node_status -eq "N" -and $servers_required -eq 2)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{`n	`"name`":`"$nodename1`",`n    `"partition`":`"$tenant`",`n    `"address`":`"$newnode1ip`"`n}`n`n"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/node" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{`n	`"name`":`"$nodename2`",`n    `"partition`":`"$tenant`",`n    `"address`":`"$newnode2ip`"`n}`n`n"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/node" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
}

if ($node_status -eq "N" -and $servers_required -eq 3)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{`n	`"name`":`"$nodename1`",`n    `"partition`":`"$tenant`",`n    `"address`":`"$newnode1ip`"`n}`n`n"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/node" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{`n	`"name`":`"$nodename2`",`n    `"partition`":`"$tenant`",`n    `"address`":`"$newnode2ip`"`n}`n`n"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/node" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{`n	`"name`":`"$nodename3`",`n    `"partition`":`"$tenant`",`n    `"address`":`"$newnode3ip`"`n}`n`n"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/node" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
}

if ($node_status -eq "N" -and $servers_required -eq 4)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{`n	`"name`":`"$nodename1`",`n    `"partition`":`"$tenant`",`n    `"address`":`"$newnode1ip`"`n}`n`n"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/node" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{`n	`"name`":`"$nodename2`",`n    `"partition`":`"$tenant`",`n    `"address`":`"$newnode2ip`"`n}`n`n"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/node" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{`n	`"name`":`"$nodename3`",`n    `"partition`":`"$tenant`",`n    `"address`":`"$newnode3ip`"`n}`n`n"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/node" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body = "{`n	`"name`":`"$nodename4`",`n    `"partition`":`"$tenant`",`n    `"address`":`"$newnode4ip`"`n}`n`n"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/node" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
}


################################################################END OF NEW NODE SECTION#################################################################

################################################################START OF POOL SECTION###################################################################


if ($servers_required -eq 1)
{ 
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body1 = "{
`n	`"name`":`"$url-$pool_port`",
`n	`"partition`":`"$tenant`",
`n	`"monitor`":`"/Common/$monitorname`",
`n	`"members`": 
`n	[
`n		{
`n            `"name`": `"${nodename1}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        }
`n    ]
`n}"
$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/pool" -Method 'POST' -Headers $headers -Body $body1
$response | ConvertTo-Json
}
if ($servers_required -eq 2)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body2 = "{
`n	`"name`":`"$url-$pool_port`",
`n	`"partition`":`"$tenant`",
`n	`"monitor`":`"/Common/$monitorname`",
`n	`"members`": 
`n	[
`n		{
`n            `"name`": `"${nodename1}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename2}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        }
`n    ]
`n}"
$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/pool" -Method 'POST' -Headers $headers -Body $body2
$response | ConvertTo-Json
}
if ($servers_required -eq 3)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body3 = "{
`n	`"name`":`"$url-$pool_port`",
`n	`"partition`":`"$tenant`",
`n	`"monitor`":`"/Common/$monitorname`",
`n	`"members`": 
`n	[
`n		{
`n            `"name`": `"${nodename1}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename2}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename3}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        }
`n    ]
`n}"
$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/pool" -Method 'POST' -Headers $headers -Body $body3
$response | ConvertTo-Json
}
if ($servers_required -eq 4)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body4 = "{
`n	`"name`":`"$url-$pool_port`",
`n	`"partition`":`"$tenant`",
`n	`"monitor`":`"/Common/$monitorname`",
`n	`"members`": 
`n	[
`n		{
`n            `"name`": `"${nodename1}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename2}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename3}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename4}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        }
`n    ]
`n}"
$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/pool" -Method 'POST' -Headers $headers -Body $body4
$response | ConvertTo-Json
}
if ($servers_required -eq 5)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body5 = "{
`n	`"name`":`"$url-$pool_port`",
`n	`"partition`":`"$tenant`",
`n	`"monitor`":`"/Common/$monitorname`",
`n	`"members`": 
`n	[
`n		{
`n            `"name`": `"${nodename1}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename2}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename3}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename4}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename5}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        }       
`n    ]
`n}"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/pool" -Method 'POST' -Headers $headers -Body $body5
$response | ConvertTo-Json
}
if ($servers_required -eq 6)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body6 = "{
`n	`"name`":`"$url-$pool_port`",
`n	`"partition`":`"$tenant`",
`n	`"monitor`":`"/Common/$monitorname`",
`n	`"members`": 
`n	[
`n		{
`n            `"name`": `"${nodename1}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename2}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename3}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename4}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename5}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename6}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        }
`n    ]
`n}"
$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/pool" -Method 'POST' -Headers $headers -Body $body6
$response | ConvertTo-Json
}
if ($servers_required -eq 7)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body7 = "{
`n	`"name`":`"$url-$pool_port`",
`n	`"partition`":`"$tenant`",
`n	`"monitor`":`"/Common/$monitorname`",
`n	`"members`": 
`n	[
`n		{
`n            `"name`": `"${nodename1}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename2}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename3}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename4}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename5}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename6}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename7}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        }
`n    ]
`n}"
$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/pool" -Method 'POST' -Headers $headers -Body $body7
$response | ConvertTo-Json
}
if ($servers_required -eq 8)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body8 = "{
`n	`"name`":`"$url-$pool_port`",
`n	`"partition`":`"$tenant`",
`n	`"monitor`":`"/Common/$monitorname`",
`n	`"members`": 
`n	[
`n		{
`n            `"name`": `"${nodename1}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename2}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename3}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename4}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename5}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename6}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename7}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename8}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        }
`n    ]
`n}"
$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/pool" -Method 'POST' -Headers $headers -Body $body8
$response | ConvertTo-Json
}
if ($servers_required -eq 9)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body9 = "{
`n	`"name`":`"$url-$pool_port`",
`n	`"partition`":`"$tenant`",
`n	`"monitor`":`"/Common/$monitorname`",
`n	`"members`": 
`n	[
`n		{
`n            `"name`": `"${nodename1}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename2}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename3}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename4}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename5}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename6}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename7}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename8}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename9}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        }
`n    ]
`n}"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/pool" -Method 'POST' -Headers $headers -Body $body9
$response | ConvertTo-Json
}
if ($servers_required -eq 10)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")

$body10 = "{
`n	`"name`":`"$url-$pool_port`",
`n	`"partition`":`"$tenant`",
`n	`"monitor`":`"/Common/$monitorname`",
`n	`"members`": 
`n	[
`n		{
`n            `"name`": `"${nodename1}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename2}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename3}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename4}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename5}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename6}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename7}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename8}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename9}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        },
`n        {
`n            `"name`": `"${nodename10}:${pool_port}`",
`n            `"partition`": `"$tenant`"
`n        }
`n    ]
`n}"
$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/pool" -Method 'POST' -Headers $headers -Body $body10
$response | ConvertTo-Json
}

################################################################END OF POOL SECTION###################################################################

################################################################START OF VIP SECTION###################################################################

#VIP SECTION

if ($irule_required -eq 1)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")


$body = "{
`n    `"name`": `"$url-$vip_port`",
`n    `"partition`": `"$tenant`",
`n    `"description`": `" ${vip_description}-${appid}`",
`n    `"destination`": `"/$tenant/${vip}:${vip_port}`",
`n    `"ipProtocol`": `"tcp`",
`n    `"mask`": `"255.255.255.255`",
`n    `"pool`": `"/$tenant/$url-$pool_port`",
`n    `"sourceAddressTranslation`":{`"type`":`"snat`",
`n    `"pool`": `"/$tenant/$snat_pool`"},
`n    `"translateAddress`": `"enabled`",
`n    `"translatePort`": `"enabled`",
`n    `"profiles`":
`n    
`n    [
`n    {
`n                `"kind`": `"tm:ltm:virtual:profiles:profilesstate`",
`n                `"name`": `"bbt-generic-http-profile`",
`n                `"partition`": `"Common`"
`n    },
`n    
`n    {
`n    	        `"name`":`"bbt-generic-tcp-lan-profile`",
`n                `"partition`": `"Common`",
`n                `"context`":`"all`"
`n    }
`n    ],
`n    `"persist`":`"/Common/$persist_name`",
`n    `"rules`":[`"/Common/$irule1`"]
`n}
`n"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/virtual" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
}


if ($irule_required -eq 2)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")


$body = "{
`n    `"name`": `"$url-$vip_port`",
`n    `"partition`": `"$tenant`",
`n    `"description`": `" ${vip_description}-${appid}`",
`n    `"destination`": `"/$tenant/${vip}:${vip_port}`",
`n    `"ipProtocol`": `"tcp`",
`n    `"mask`": `"255.255.255.255`",
`n    `"pool`": `"/$tenant/$url-$pool_port`",
`n    `"sourceAddressTranslation`":{`"type`":`"snat`",
`n    `"pool`": `"/$tenant/$snat_pool`"},
`n    `"translateAddress`": `"enabled`",
`n    `"translatePort`": `"enabled`",
`n    `"profiles`":
`n    
`n    [
`n    {
`n                `"kind`": `"tm:ltm:virtual:profiles:profilesstate`",
`n                `"name`": `"bbt-generic-http-profile`",
`n                `"partition`": `"Common`"
`n    },
`n    
`n    {
`n    	        `"name`":`"bbt-generic-tcp-lan-profile`",
`n                `"partition`": `"Common`",
`n                `"context`":`"all`"
`n    }
`n    ],
`n    `"persist`":`"/Common/$persist_name`",
`n    `"rules`":[`"/Common/$irule1`", `"/Common/$irule2`"]
`n}
`n"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/virtual" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
}


if ($irule_required -eq 3)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")


$body = "{
`n    `"name`": `"$url-$vip_port`",
`n    `"partition`": `"$tenant`",
`n    `"description`": `" ${vip_description}-${appid}`",
`n    `"destination`": `"/$tenant/${vip}:${vip_port}`",
`n    `"ipProtocol`": `"tcp`",
`n    `"mask`": `"255.255.255.255`",
`n    `"pool`": `"/$tenant/$url-$pool_port`",
`n    `"sourceAddressTranslation`":{`"type`":`"snat`",
`n    `"pool`": `"/$tenant/$snat_pool`"},
`n    `"translateAddress`": `"enabled`",
`n    `"translatePort`": `"enabled`",
`n    `"profiles`":
`n    
`n    [
`n    {
`n                `"kind`": `"tm:ltm:virtual:profiles:profilesstate`",
`n                `"name`": `"bbt-generic-http-profile`",
`n                `"partition`": `"Common`"
`n    },
`n    
`n    {
`n    	        `"name`":`"bbt-generic-tcp-lan-profile`",
`n                `"partition`": `"Common`",
`n                `"context`":`"all`"
`n    }
`n    ],
`n    `"persist`":`"/Common/$persist_name`",
`n    `"rules`":[`"/Common/$irule1`", `"/Common/$irule2`", `"/Common/$irule3`"]
`n}
`n"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/virtual" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
}


if ($irule_required -eq 4)
{
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("X-F5-Auth-Token", "$token")


$body = "{
`n    `"name`": `"$url-$vip_port`",
`n    `"partition`": `"$tenant`",
`n    `"description`": `" ${vip_description}-${appid}`",
`n    `"destination`": `"/$tenant/${vip}:${vip_port}`",
`n    `"ipProtocol`": `"tcp`",
`n    `"mask`": `"255.255.255.255`",
`n    `"pool`": `"/$tenant/$url-$pool_port`",
`n    `"sourceAddressTranslation`":{`"type`":`"snat`",
`n    `"pool`": `"/$tenant/$snat_pool`"},
`n    `"translateAddress`": `"enabled`",
`n    `"translatePort`": `"enabled`",
`n    `"profiles`":
`n    
`n    [
`n    {
`n                `"kind`": `"tm:ltm:virtual:profiles:profilesstate`",
`n                `"name`": `"bbt-generic-http-profile`",
`n                `"partition`": `"Common`"
`n    },
`n    
`n    {
`n    	        `"name`":`"bbt-generic-tcp-lan-profile`",
`n                `"partition`": `"Common`",
`n                `"context`":`"all`"
`n    }
`n    ],
`n    `"persist`":`"/Common/$persist_name`",
`n    `"rules`":[`"/Common/$irule1`", `"/Common/$irule2`", `"/Common/$irule3`", `"/Common/$irule4`"]
`n}
`n"

$response = Invoke-RestMethod "https://$f5ip/mgmt/tm/ltm/virtual" -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json
}

################################################################END OF VIP SECTION###################################################################