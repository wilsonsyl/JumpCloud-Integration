#!/bin/bash
# To update the dynamic IP address to the radius server

curip=$(curl -q http://ipecho.net/plain)
previp=$(cat /jffs/scripts/previp.txt)
apikey="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
name="WiFi"
sharedsecret="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
mfa="MAINTAIN"
userLockoutAction="MAINTAIN"
userPasswordExpirationAction="MAINTAIN"
radiusid=xxxxxxxxxxxxxxxxxxxxxxxx


if [ "$previp" != "$curip" ]
then
echo "$curip" > /jffs/scripts/previp.txt
curl \
  -X 'PUT' \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H "x-api-key:$apikey" \
  -d '{"name" : $name, "sharedSecret" : $sharedsecret, "networkSourceIp":$curip,"mfa":$mfa,"userLockoutAction":$userLockoutAction,"userPasswordExpirationAction":$userPasswordExpirationAction}' \
  "https://console.jumpcloud.com/api/radiusservers/$radiusid"
fi
