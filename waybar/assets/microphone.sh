# ~/.config/waybar/assets/microphone.sh

#!/bin/bash

# Loop para manter o módulo atualizado
while true; do
    # Obtém o volume e o status de mudo do microfone padrão
    output=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null)

    # Extrai a porcentagem do volume
    volume=$(awk -v out="$output" 'BEGIN { split(out, a, " "); printf "%.0f\n", a[2] * 100 }')

    # Verifica se está mudo
    if [[ "$output" == *"[MUTED]"* ]]; then
      muted="yes"
    else
      muted="no"
    fi

    # Define o ícone e o texto de acordo com o status
    if [ "$muted" = "yes" ]; then
      text_output=" Mutado" # Ícone de microfone mudo
    else
      text_output=" ${volume}%" # Ícone de microfone com porcentagem
    fi

    # Gera a saída JSON para a Waybar
    echo "{\"text\": \"$text_output\", \"tooltip\": \"Microfone: ${volume}%\", \"class\": \"custom-microphone\"}"
done