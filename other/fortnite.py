
import json
import sys, subprocess
sys.path.insert(1, 'packages')

subprocess.run('cls', shell=True)

import aiohttp
import asyncio
import webbrowser


# I forgot I had these lmao
DAUNTLESS_TOKEN = "YjA3MGYyMDcyOWY4NDY5M2I1ZDYyMWM5MDRmYzViYzI6SEdAWEUmVEdDeEVKc2dUIyZfcDJdPWFSbyN+Pj0+K2M2UGhSKXpYUA=="
SWITCH_TOKEN = "OThmN2U0MmMyZTNhNGY4NmE3NGViNDNmYmI0MWVkMzk6MGEyNDQ5YTItMDAxYS00NTFlLWFmZWMtM2U4MTI5MDFjNGQ3"
IOS_TOKEN = "MzQ0NmNkNzI2OTRjNGE0NDg1ZDgxYjc3YWRiYjIxNDE6OTIwOWQ0YTVlMjVhNDU3ZmI5YjA3NDg5ZDMxM2I0MWE="




http = None

access_token = ""
user_agent = f"Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0"

async def generate_device_auths() -> None:
    http = aiohttp.ClientSession(
        headers={
            'User-Agent': user_agent
        }
    )



    async with aiohttp.request(
            method="POST",
            url="https://account-public-service-prod.ol.epicgames.com/account/api/oauth/token",
            headers={
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": f"basic {SWITCH_TOKEN}"
            },
            data={
                "grant_type": "client_credentials",
            }
    ) as request:
        data = await request.json()
        
    access_token = data['access_token']

    async with aiohttp.request(
            method="POST",
            url="https://account-public-service-prod03.ol.epicgames.com/account/api/oauth/deviceAuthorization",
            headers={
                "Authorization": f"bearer {access_token}",
                "Content-Type": "application/x-www-form-urlencoded"
            }
    ) as request:
        data = await request.json()
        
        

    device_code = data['user_code'], data['device_code']
    
    print(f"[Info] Please login using this link: https://www.epicgames.com/activate?userCode={device_code[0]}")
    
    
    webbrowser.open(f"https://www.epicgames.com/activate?userCode={device_code[0]}", new=1)



    code = device_code[1]
    
    
    
    while True:
        async with aiohttp.request(
            method="POST",
            url="https://account-public-service-prod03.ol.epicgames.com/account/api/oauth/token",
            headers={
                "Authorization": f"basic {SWITCH_TOKEN}",
                "Content-Type": "application/x-www-form-urlencoded"
            },
            data={
                "grant_type": "device_code",
                "device_code": code
            }
        ) as request:
            token = await request.json()

            if request.status == 200:
                break
            else:
                if token['errorCode'] == 'errors.com.epicgames.account.oauth.authorization_pending':
                    pass
                elif token['errorCode'] == 'errors.com.epicgames.not_found':
                    pass
                else:
                    print(json.dumps(token, sort_keys=False, indent=4))

            await asyncio.sleep(5)

    async with aiohttp.request(
        method="GET",
        url="https://account-public-service-prod03.ol.epicgames.com/account/api/oauth/exchange",
        headers={
            "Authorization": f"bearer {token['access_token']}"
        }
    ) as request:
        exchange = await request.json()

    async with aiohttp.request(
        method="POST",
        url="https://account-public-service-prod03.ol.epicgames.com/account/api/oauth/token",
        headers={
            "Authorization": f"basic {IOS_TOKEN}",
            "Content-Type": "application/x-www-form-urlencoded"
        },
        data={
            "grant_type": "exchange_code",
            "exchange_code": exchange['code']
        }
    ) as request:
        data = await request.json()
        
        access_token = data.get('access_token', '')
        account_id = data.get('account_id', '')
        







    async with aiohttp.request(
        method="POST",
        url="https://account-public-service-prod.ol.epicgames.com/"
            f"account/api/public/account/{account_id}/deviceAuth",
        headers={
            "Authorization": f"bearer {access_token}",
            "Content-Type": "application/json"
        }
    ) as request:
        data = await request.json()


    await http.close()

    return {
        "device_id": data['deviceId'],
        "account_id": data['accountId'],
        "secret": data['secret'],
        "user_agent": data['userAgent'],
        "created": {
            "location": data['created']['location'],
            "ip_address": data['created']['ipAddress'],
            "datetime": data['created']['dateTime']
        }
    }

returnAuths = asyncio.run(generate_device_auths())

subprocess.run('cls', shell=True)

device_id = returnAuths['device_id']
account_id = returnAuths['account_id']
secret = returnAuths['secret']


# Data to be written
logs = {
  "accountId": f"{account_id}",
  "deviceId": f"{device_id}",
  "secret": f"{secret}"
}

print(logs)

print("""
      
      -----------------------------
      
      """)
 
# Serializing json
json_object = json.dumps(logs, indent=2)



input1 = input("[Question] Auth name: ")
authName = input1 + ".json"
# output


 
# Writing to sample.json
with open(f"../auths/{authName}", "w") as outfile:
    outfile.write(json_object)
    
print("[Info] Successfully saved auth to " + authName)


input("Press Enter to exit")

exit()



