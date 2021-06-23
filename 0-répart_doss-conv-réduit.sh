#! /bin/bash
# création de dossiers d'après le nombres d'images à traiter (10 images par dossier)
read -p 'Nombre de pages à répartir ?  ' ni
nd=$((($ni / 10) + 1))
dd=$(($ni / 10))
nnd=$(($nd * 10))
reste=$(($nnd - $ni))
nf=$nd
mkdir $nd
nn=$nd
while [ "$nn" -ne 1 ]; do
nn=$(($nn - 1))
	mkdir $nn
done
echo $nd' dossiers ont été créés.'

# répartition des '$ni' images dans les '$nf' $dossiers
# déterminer une variable $diz correspondant à chaque dizaine d'images
diz=0
while [ "$diz" -ne "$nd" ]; do
ddiz=$(($diz * 10))
# déplacer les 10 images correspondant à la dizaine $diz dans le dossier $nf
nb=1
while [ "$nb" -ne 11 ]
	do
# sélectionner l'image (($diz + $nb)).jpg pour la déplacer dans le dossier $nf
		img=$(($ddiz + $nb)).jpg
			mv $img $(($diz + 1))
		nb=$(($nb + 1))
	done
diz=$(($diz + 1))
done
cd 1
mv 10.jpg a.jpg
cd ..
if [ $ni -gt 99 ]
then
cd 10
mv 100.jpg b.jpg
cd ..
else 
echo "Fini !"
fi

# convertit les jpg contenus dans chaque dossier en fichier pdf puis en réduire le poids
# il faut indiquer les noms des dossiers à traiter au lancement du script

chemin=$(pwd)
# for i in "$@"
i=1
j=$(($ni / 10))
declare -i j
k=$(($j + 2))
while [ "$i" -lt "$k" ]; do
		echo "   "
		echo "À présent, je travaille dans le dossier $i."
			cd $i
			convert -compress jpeg *.jpg $i.pdf
			echo "   "
			echo "Je déplace le fichier $i.pdf dans le dossier de travail."
			mv $i.pdf $chemin
			cd ..
			echo "    "
			echo "J'allège le fichier $i.pdf."; pdf2ps $i.pdf; ps2pdf $i.ps $i.pdf; rm $i.ps
			echo "C'est fait."
			echo "- - - - - - - -"
		i=$(($i + 1))
done
	
echo -e "==========>${green} TERMINÉ ! ${reset}"
echo "   "
echo "   "
