#!/bin/bash

# Rofi-Bluetooth
# Adaptado para interagir com bluetoothctl

# Exibe um menu para ligar/desligar o bluetooth
show_power_menu() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        power_option=" Desligar Bluetooth"
    else
        power_option=" Ligar Bluetooth"
    fi

    echo "$power_option"
    echo "Scanear Dispositivos"
}

# Alterna o estado de energia do bluetooth
toggle_power() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        bluetoothctl power off
    else
        bluetoothctl power on
    fi
}

# Escaneia, lista e permite conectar a dispositivos
scan_and_connect() {
    (bluetoothctl scan on &) | dmenu -p "Scanning..." -l 1 &
    sleep 5
    bluetoothctl scan off

    devices=$(bluetoothctl devices | awk '{print $3, $4, $5, $2}')
    selected_device=$(echo "$devices" | rofi -dmenu -p "Selecione um dispositivo" | awk '{print $NF}')

    if [ -n "$selected_device" ]; then
        bluetoothctl connect "$selected_device"
    fi
}

# Menu principal
main_menu_choice=$(show_power_menu | rofi -dmenu -p "Bluetooth")

case "$main_menu_choice" in
    " Ligar Bluetooth"|" Desligar Bluetooth")
        toggle_power
        ;;
    "Scanear Dispositivos")
        scan_and_connect
        ;;
esac