#!/bin/bash
# Créer un dossier Duplicates a la racine
### Les sous dossiers seront aussi traités
### Attention a Duplicates qui est a la racine de home/jpg
## Ameliorations : Passer au chemin relatif : passer des parametre au script.
## $1 parametre du dossier de départ du script (le dossier que l'on soite traiter)
## faire un essai du scrip en utilisant $1


#Création du dossier Duplicates et du fichier duplicate.txt
cd $HOME

if [ ! -d Duplicates ]
  then
    mkdir -p Duplicates
    touch /home/jpg/Duplicates/duplicates.txt
fi

###Nettoyage
rm /home/jpg/Duplicates/duplicates.txt >/dev/null
touch /home/jpg/Duplicates/duplicates.txt
### SEARCH
fdupes -fr $1 > /home/jpg/Duplicates/duplicates.txt
#fdupes -fr "/home/jpg/hdd1-raspi-1/Images" > /home/jpg/Duplicates/duplicates.txt
### Déplacement
for ligne in $(cat /home/jpg/Duplicates/duplicates.txt)
do
echo "deplacement de $ligne"
mv $ligne -t /home/jpg/Duplicates/
done
