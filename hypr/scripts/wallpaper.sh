#!/usr/bin/env bash

#Escolha um wallpaper aleatorio
NEW_WP=$(ls $HOME/Pictures/wallpapers | shuf -n 1)

#Caminho completo para wallpaper
WALLPAPER="$HOME/Pictures/wallpapers/$NEW_WP"

#Caminho do arquivo de configuracao
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

#Limpar o arquivo de configuracao do hyprpaper
echo " " > $HYPRPAPER_CONF

#Mudar o conteudo do hyprpaper.conf
echo "preload = $WALLPAPER" >> $HYPRPAPER_CONF
echo "wallpaper = eDP-1,$WALLPAPER" >> $HYPRPAPER_CONF
echo "splash = false" >> $HYPRPAPER_CONF

#Reiniciar o hyprpaper
killall hyprpaper
hyprpaper &