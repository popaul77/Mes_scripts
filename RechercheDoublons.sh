#!/bin/bash
# Créer un dossier Duplicates a la racine
### Les sous dossiers seront aussi traités
### Attention a Duplicates qui est a la racine de home/jpg
## Ameliorations : Passer au chemin relatif : passer des parametre au script.
## $1 parametre du dossier de départ du script (le dossier que l'on soite traiter)

## Passer le chemin du dossier a traiter en paramettre du script
## exemple le-script.sh /home/jpg/mon_dossier_a_traiter

#Création du dossier Duplicates et du fichier duplicate.txt
cd $HOME

if [ ! -d Duplicates ]
  then
    mkdir -p Duplicates
    touch Duplicates/duplicates.txt
fi

if [ ! -e Duplicates/duplicates.txt ]
  then
    touch Duplicates/duplicates.txt
fi

DUP=$HOME/Duplicates
LISTE=$DUP/duplicates.txt

###Nettoyage
rm $LISTE >/dev/null
touch $LISTE

## supression espace si besoin
for a in $1*
do
  b=$(echo $a | sed 's/ /_/g');
  mv "$a" "$b" 2>/dev/null;
done


### SEARCH
fdupes -fr $1 > $LISTE

### Déplacement
for ligne in $(cat $LISTE )
do
  echo "deplacement de $ligne"
  mv $ligne -t $DUP/
done
