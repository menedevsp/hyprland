# ~/.config/waybar/assets/brightness_bar.sh

#!/bin/bash

# Obtém o brilho atual em porcentagem
PERCENT=$(brightnessctl get)
MAX=$(brightnessctl max)
PERCENT_NUM=$((PERCENT * 100 / MAX))

# Envia o JSON para a Waybar com a porcentagem no texto
echo "{\"text\": \"󰃠 ${PERCENT_NUM}%\", \"tooltip\": \"Brilho: ${PERCENT_NUM}%\", \"class\": \"custom-wl-gammarelay-brightness\"}"



# # Obtém o brilho atual em porcentagem (ex: 90)
# PERCENT=$(brightnessctl get)
# MAX=$(brightnessctl max)
# PERCENT_NUM=$((PERCENT * 100 / MAX))


# # Cria a barra
# FILLED=$((PERCENT_NUM / 10))
# EMPTY=$((10 - FILLED))

# BAR=""
# for ((i = 0; i < FILLED; i++)); do BAR+="▮"; done
# for ((i = 0; i < EMPTY; i++)); do BAR+="▯"; done

# # Envia o JSON para a Waybar
# echo "{\"text\": \"󰃠 $BAR\", \"tooltip\": \"Brilho: ${PERCENT_NUM}%\", \"class\": \"custom-wl-gammarelay-brightness\"}"