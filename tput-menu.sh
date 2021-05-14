#!/bin/bash

# Utilisation de tput pour un menu
tput clear

function menu ()
{
tput cup 3 15
tput setaf 3
echo "www.popaul77.org"
tput sgr0

tput cup 5 17
tput rev
echo "Menu Principal"
tput sgr0

tput cup 7 15
echo "1. Transformer png2jpg"

tput cup 8 15
echo "2. Transformer jpg2png"

tput bold
tput cup 9 15
echo "------------------------"
tput sgr0

tput cup 10 15
echo "3. Ameliorer jpg"

tput cup 11 15
echo "4. Ameliorer png"

tput bold
tput cup 13 15
read -p "Entrer votre choix [1-4] : " choix
tput sgr0
echo ""
}

menu

if [ $choix -eq 1 ]; then
  echo "Fonction png2jpg."
elif [ $choix -eq 2 ]; then
  echo "Fonction jpg2png."
elif [ $choix -eq 3 ]; then
  echo "Fonction Amelioration jpg."
elif [ $choix -eq 4 ]; then
  echo "Fonction Amelioration png."
else echo "Preciser la fonction a executer"
fi

echo ""
echo ""
echo "Vous avez choisi la fonction $choix." | boxes -d dog
echo ""
