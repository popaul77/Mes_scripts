#!/usr/bin/env bash
# emporte piece pour ariel
# il sera necessaire de specifier les arguments (ex: 1 2 3 6 9)
# https://legacy.imagemagick.org/Usage/
# on va utiliser convert crop $@ $? et %d + des couleurs pour le fun
#######################################################################

# Ansi color code variables
red="\e[0;91m"
blue="\e[0;94m"
expand_bg="\e[K"
blue_bg="\e[0;104m${expand_bg}"
red_bg="\e[0;101m${expand_bg}"
green_bg="\e[0;102m${expand_bg}"
green="\e[0;92m"
white="\e[0;97m"
bold="\e[1m"
uline="\e[4m"
reset="\e[0m"

#ma variable
#DEST=/home/jpg/test4

#Création du dossier resultat
if [ ! -d ./resultat ]
  then
    mkdir resultat
fi

#on va dans le dossier d'execution
#cd $DEST

#c'est parti pour le script
for i in "$@"
	do
		echo "Découpe de l'image $i"
		convert $i.jpg -crop 2x1+0+0@ +repage +adjoin resultat/$i"-decoupe_%d.jpg"
	done

# Message de fin
  if [ $? -eq 0 ]; then
     echo -e "Crop performed ==========>${green} OK ${reset}"
  else
     echo -e "Crop performed ==========>${red} FAILED ${reset}"
  fi
