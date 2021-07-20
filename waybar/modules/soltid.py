#!/usr/bin/python

import requests
import json
import datetime


def safetim_to_str(safetime) -> str:
    hours = safetime["safeTimeHours"]
    minutes = safetime["safeTimeMinutes"]

    description = safetime["shadowDescription"].capitalize()

    if safetime["restOfDay"]:
        return f"{description}: "

    out = f"{description}: {hours}h"
    if minutes != 0:
        out += f" {minutes}min"

    return out


if __name__ == "__main__":
    headers = {
        "Content-type": "application/json",
        "user-agent": "Mozilla/5.0 (X11; Linux x86_64)",
    }

    datestring = datetime.datetime.today().strftime("%Y-%m-%d")
    hour = datetime.datetime.today().hour
    data = {
        "skinTypeId": 2,
        "latitude": "57.70887",
        "dateStr": datestring,
        "hour": hour,
    }

    r = requests.post(
        "https://www.stralsakerhetsmyndigheten.se/api/v1/suntime/calculate",
        headers=headers,
        data=json.dumps(data),
    )

    if not r.ok:
        print(json.dumps({"text": "", "tooltip": f"error: {r.reason}"}))

    response = json.loads(r.text)

    out_str = [
        safetim_to_str(safetime) for safetime in response["result"]["safeTimeResults"]
    ]

    result = {"text": "", "tooltip": "\n".join(out_str)}
    print(json.dumps(result))
