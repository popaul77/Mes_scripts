#!/usr/bin/env bash

## extraction des cartes de previsions de vent celon arome
## preciser l'heure de creation du modele dans la commande qui execute le script
## exemple .meteociel.sh 12
## on peut aussi le mettre en dur dans le script a la place de $1

DIR_DEST=$HOME/test3
DATE_MODELE="$(date +%Y%m%d$1)"

function cartes()
{
rm $DIR_DEST/*

for i in {1..48}
    do
      wget -q -c -P $DIR_DEST http://modeles7.meteociel.fr/modeles/arome/runs/$DATE_MODELE/aromehd-1-$i-0.png
    done
}

function creegif ()
{
  cd $DIR_DEST
  convert -delay 200 -loop 0 aromehd-1-*-0.png animated.gif
}

cartes
creegif
