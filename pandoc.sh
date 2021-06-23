#!/bin/sh
# utiliser pandoc avec un script sur des fichiers multiples

# transforme en .md
for i in *; do pandoc -o $i.md $i; done

#supprime le .txt
rm *.txt

# supprime l'extension .txt.md
for i in *; do mv $i ${i%%.*}; done

# remet un extension .md a tous les fichiers
for i in *; do mv $i $i.md; done
