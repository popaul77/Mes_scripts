#!/bin/bash
# Script de Gérard pour ariel
# VARIABLES
# indiquer le répertoire de travail (à modifier selon)
DIR="$HOME/Images/BacSable/jpg2pdf/"

cd $DIR

#--- réduction des images en 600x900 (images en portrait)
for file in *.jpg; do
       convert $file -resize 600x $file;
       echo "Traitement image $file";
    done

#regrouper les jpg dans un pdf
convert *.jpg livret.pdf
