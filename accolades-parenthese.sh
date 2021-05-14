#! /bin/bash

echo -e "#############################"
echo -e "# Utilisation des accolades #"
echo -e "#############################"

echo -e "\nRépertoire courant : \c"
pwd
echo -e "Initialisation de la variable \"v\" :\nv=\"abc\""
v="abc"
echo -e "\nDébut de l'environnement avec accolades...\n"
{
echo -e "Réaffectation de la variable \"v\" :\nv=\"123\""
v="123"
echo -e "\nAffichage de la variable \"v\" : \c"
echo -e "$v"
echo -e "\nChangement de répertoire : "
echo -e "cd /tmp"
cd /tmp
echo -e "\nRépertoire courant : \c"
pwd
}
echo -e "\nFin de l'environnement avec accolades...\n"

echo -e "\nRépertoire courant : \c"
pwd
echo -e "\nAffichage de la variable \"v\" : \c"
echo -e "$v"
echo

unset v
cd $HOME

echo -e "Appuyez sur une touche pour continuer..."
read touche

echo -e "###############################"
echo -e "# Utilisation des parenthèses #"
echo -e "###############################"

echo -e "\nRépertoire courant : \c"
pwd
echo -e "Initialisation de la variable \"v\" :\nv=\"abc\""
v="abc"
echo -e "\nDébut de l'environnement avec parenthèses...\n"
(
echo -e "Réaffectation de la variable \"v\" :\nv=\"123\""
v="123"
echo -e "\nAffichage de la variable \"v\" : \c"
echo -e "$v"
echo -e "\nChangement de répertoire : "
echo -e "cd /tmp"
cd /tmp
echo -e "\nRépertoire courant : \c"
pwd
)
echo -e "\nFin de l'environnement avec parenthèses...\n"

echo -e "\nRépertoire courant : \c"
pwd
echo -e "\nAffichage de la variable \"v\" : \c"
echo -e "$v"
echo
exit
