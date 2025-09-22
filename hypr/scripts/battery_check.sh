#!/bin/bash

BATTERY_LEVEL_CRITICAL=25
BRIGHTNESS_LOW="15%"
CHECK_INTERVAL=60

dim_smoothly() {
    local target_percent_str=$1
    local target_percent=${target_percent_str//%}
    local current_raw=$(brightnessctl get)
    local max_raw=$(brightnessctl max)
    local current_percent=$((current_raw * 100 / max_raw))
    if [ "$current_percent" -gt "$target_percent" ]; then
        for i in $(seq "$current_percent" -1 "$target_percent"); do
            brightnessctl set "$i%"
            sleep 0.02
        done
    fi
}

notified_full=0

while true; do
    BATT_STATUS=$(cat /sys/class/power_supply/BAT0/status)
    BATT_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)

    if [ "$BATT_STATUS" = "Discharging" ] && [ "$BATT_CAPACITY" -le "$BATTERY_LEVEL_CRITICAL" ]; then
        notify-send "Bateria Fraca!" "Nível em ${BATT_CAPACITY}%. Conecte o carregador." -u critical
        dim_smoothly "$BRIGHTNESS_LOW"
        sleep 300
    elif [[ "$BATT_STATUS" == "Full" || ( "$BATT_STATUS" == "Charging" && "$BATT_CAPACITY" -eq 100 ) ]] && [ "$notified_full" -eq 0 ]; then
        notify-send "Bateria Carregada" "Carga completa em 100%. Pode remover o carregador." -u normal
        notified_full=1
        sleep "$CHECK_INTERVAL"
    elif [ "$BATT_STATUS" = "Discharging" ]; then
        notified_full=0
        sleep "$CHECK_INTERVAL"
    else
        sleep "$CHECK_INTERVAL"
    fi
done