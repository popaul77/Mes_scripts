#!/bin/bash

# Utilisation de SECONDS et boxes (apt install boxes)
# pour avoir le temps d'éxecution d'un script ou partie
# dans une boite top.


function chrono ()
{
echo $SECONDS
}

function boucle ()
{
  for i in {0..1000000}
  do
    echo $i
  done
  echo "Temps écoulé pour la boucle = $(chrono) secondes"
}

boucle
sleep 3
echo "Temps écoulé depuis le debut du script = $(chrono) secondes"
