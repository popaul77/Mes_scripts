#!/bin/bash

DIR=/home/jpg/Documents/Ze-Documents_Ariel
FICH=$DIR/Themes.txt

cd $DIR

# Combien de mot dans ce fichier
WORD=$(wc -w $FICH)
LIGNES=$(wc -l $FICH)
echo "Nombre de mots= "$WORD
echo "Nombre de lignes = "$LIGNES

# suppression de doublon
#sort -u Themes.txt > themes1.txt

# Supprimer les blanc debut et fin de ligne
#sed "s/^\ //;s/\ $//" /tmp/Champ1.txt > /tmp/Champ11.txt

#Supprimer ligne vide
#sed '/^\s*$/d'

# Extraction du champ 1
cut -d ';' -f1 $FICH > /tmp/Champ1.txt
sed "s/^\ //;s/\ $//" /tmp/Champ1.txt > /tmp/Champ11.txt
sort -u /tmp/Champ11.txt > $DIR/Champ1.txt
sed -i '/^$/d' $DIR/Champ1.txt


# Extraction du champ2
cut -d ';' -f2 $FICH > /tmp/Champ2.txt
sed "s/^\ //;s/\ $//" /tmp/Champ2.txt > /tmp/Champ21.txt
sort -u /tmp/Champ21.txt > $DIR/Champ2.txt
sed -i '/^$/d' $DIR/Champ2.txt

# Extraction du champ 3
cut -d ';' -f3 $FICH > /tmp/Champ3.txt
sed "s/^\ //;s/\ $//" /tmp/Champ3.txt > /tmp/Champ31.txt
sort -u /tmp/Champ31.txt > $DIR/Champ3.txt
sed -i '/^$/d' $DIR/Champ3.txt

# Extraction du champ 4
cut -d ';' -f4 $FICH > /tmp/Champ4.txt
sed "s/^\ //;s/\ $//" /tmp/Champ4.txt > /tmp/Champ41.txt
sort -u /tmp/Champ41.txt > $DIR/Champ4.txt
sed -i '/^$/d' $DIR/Champ4.txt

# Extraction du champ 5
cut -d ';' -f5 $FICH > /tmp/Champ5.txt
sed "s/^\ //;s/\ $//" /tmp/Champ5.txt > /tmp/Champ51.txt
sort -u /tmp/Champ51.txt > $DIR/Champ5.txt
sed -i '/^$/d' $DIR/Champ5.txt

# Extraction du champ 6
cut -d ';' -f6 $FICH > /tmp/Champ6.txt
sed "s/^\ //;s/\ $//" /tmp/Champ6.txt > /tmp/Champ61.txt
sort -u /tmp/Champ61.txt > $DIR/Champ6.txt
sed -i '/^$/d' $DIR/Champ6.txt



# Concatenation dans champ-global.txt
touch champ-global.txt

cat Champ1.txt > champ-global.txt
cat Champ2.txt >> champ-global.txt
cat Champ3.txt >> champ-global.txt
cat Champ4.txt >> champ-global.txt
cat Champ5.txt >> champ-global.txt
cat Champ6.txt >> champ-global.txt

sort -u champ-global.txt >global.txt

GLOBAL=global.txt
# Combien de mot dans ce fichier
WORD=$(wc -w $GLOBAL)
LIGNES=$(wc -l $GLOBAL)
echo "Nombre de mots= "$WORD
echo "Nombre de lignes = "$LIGNES
#wc -w champ-global.txt
