#! /bin/bash

read -p "JPG (sans extension) : " f

#récup largeur hauteur --> WIDTH, HEIGHT
identify -format %w $f.jpg > wvalue
identify -format %h $f.jpg > hvalue
HEIGHT=$(cat wvalue)
WIDTH=$(cat hvalue)
echo "hauteur : $HEIGHT"	
echo "largeur : $WIDTH"	
echo "-------------"

# division par 2 et dans l et h
h=$(($HEIGHT/2))
l=$(($WIDTH/2))
echo "hauteur/2 : $h"
echo "largeur/2: $l"	
echo "----------------"

# crop avec les dimensions l et h
convert -crop "$l"x"$h"+0+0  $f.jpg  $f"a".jpg
convert -crop "$l"x"$h"+"$h"+0  $f.jpg  $f"b".jpg
echo "C'est fait !"   
