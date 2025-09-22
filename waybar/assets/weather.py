#!/usr/bin/env python3

import json

from pyquery import PyQuery  # install using `pip install pyquery`

################################### CONFIGURATION ###################################
location_id = "0834792e2deb41cb831876732bfacc0a674f73a3133bb91550dc5fe86d45bed0"

# celcius or fahrenheit
unit = "metric"  # metric or imperial

# forcase type
forecast_type = "Hourly"  # Hourly or Daily

########################################## MAIN ##################################

# get html page
_l = "en-IN" if unit == "metric" else "en-US"
url = f"https://weather.com/{_l}/weather/today/l/{location_id}"

# get html data
html_data = PyQuery(url=url)

# current temperature
temp = html_data("span[data-testid='TemperatureValue']").eq(0).text()

# min-max temperature
temp_min = (
    html_data("div[data-testid='wxData'] > span[data-testid='TemperatureValue']")
    .eq(1)
    .text()
)
temp_max = (
    html_data("div[data-testid='wxData'] > span[data-testid='TemperatureValue']")
    .eq(0)
    .text()
)

out_data = {
    "text": f"  {temp}C",
    "tooltip": f"Min: {temp_min}C\nMax: {temp_max}C",
}
print(json.dumps(out_data))