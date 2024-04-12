import requests
from datetime import datetime
import pytz

def healthcheck(url):
    try:
        public_ip = open("./terraform/public_ip.txt", "r").read().strip()
        response = requests.get(url)

        if response.status_code == 200:
            server_time_str = response.text.strip()
            server_time = datetime.strptime(server_time_str, "%Y-%m-%d %H:%M:%S")
            server_time = pytz.utc.localize(server_time)
            current_time = datetime.now(pytz.utc)
            print("Current Time (UTC): ", current_time)
            print("Server Time (UTC):", server_time)

            time_diff = abs((current_time - server_time).total_seconds())
            if time_diff <= 1:
                print("Service is up and clock is synchronized.")
                return True
            else:
                print("Service is up but clock is desynchronized by more than 1 second.")
                return False
        else:
            print("Service is down.")
            return False
    except requests.exceptions.RequestException as e:
        print("Service is not reachable.")
        return False


public_ip = open("./terraform/public_ip.txt", "r").read().strip()
url = f"http://{public_ip}/now"
result = healthcheck(url)
print("Healthcheck result:", result)
