#!/bin/bash
#################################################################################
# Description: Permet de faire un backup du home avec rsync sur un media USB.   #
# /!\ Une mauvaise utilisation de rsync peut entrainer une perte de donnees.    #
# Dependances: rsync;                                                           #
# Auteur:  Jean-Paul                                                            #
# Licence: GPL   / Version: all                                                 #
# Infos options site :http://www.delafond.org/traducmanfr/man/man1/rsync.1.html #                                                                           #
# Bien lire les consignes avant de faire quoi que ce soit                       #
# La modification du script pour usage personnel est obligatoire                #
# Ce script est un peut long mais il fonctionne parfaitement fonction des       #
# options rsync qu'on lui donne                                                 #
# Il ne fonctionne qu'avec un seul dique usb, sinon il faut modifier le script  #
# Donner un nom clair a votre disque dur avec l'application "disk" avant de     #
# commencer choisir un disque ayant plus de place que necessaire                #
#################################################################################

#_______________PARAMETRES ET OPTIONS DE CONFIGURATION DU SCRIPTS_______________#
# Entrez le chemin vers la clé USB, disque dur ou autre (sans slash à la fin):
USB=/media/jpg/DATA-JPG #Remplacer DATA-JPG par le nom de votre disque dur

# Dossier source de la sauvegarde (Default: /home/votre-nom): Laisser comme presenté ci dessous
SOURCE=~/Images/

# Dossier de destination de la sauvegarde (Default: /media/clef_USB/home-votre_nom): a laisser comme ça
DIRBAK=$USB/home-$USER-Dell-Images/

# Démonter automatiquement le support USB la fin du script ? ("Y"=oui; ""=non): pour moi c'est non
DEMONTER="N"

# Répondre automatiquement à la question pour ne pas avoir à intervenir ? ("Y"=oui; ""=non):
YESNO="" #Cette option ne fonctionne pas, laisser vide!

# Nom et destination du fichier de log (Defaut: /media/clef_USB/home-votre_nom/.rsync.log):
LOG="$DIRBAK".rsync.log

# Options de rsync (Voir man rsync): Prendre le temps de bien comprendre cette ligne
# dirtoq = q=quiet r=recursive d=directories i=resumé des changements t=time o=owner
OPTIONS="-dirtoq --delete --log-file="$LOG"" 

#################################################################################
#____________________VARIABLES DE MISE EN FORME DU TEXTE________________________#
JAUNE="\E[33;40m" # Texte jaune;fond gris
BLANC="\E[37;40m" # Texte blanc;fond gris
ROUGE="\E[31;40m" # Texte rouge;fond gris
ALIGNR="\e["70"\`" # Aligner le texte à droite
OK="$ALIGNR [ OK ]" # Affiche [ OK ] quand ça fonctionne
FAIL="$ALIGNR $ROUGE [ FAIL ] $BLANC" # Affiche [ fail ] en cas d'erreur
#################################################################################

#____________________FONCTIONS DE SORTIES DU SCRIPT_____________________________#
function terminer0 {
	echo -e "* Sauvegarde complète de $SOURCE $OK"
	if [ "$DEMONTER" = "Y" ]; then
		umount $USB
		if [ "$?" != "0" ]; then
			echo -e "* Démontage de $USB $FAIL"
		else
			echo -e "* Démontage de $USB $OK"
		fi
	fi
	echo -e $JAUNE
	echo "* Appuyer sur <Entrer> pour quitter..."
	read
	exit 0
}
function terminer1 {
	echo -e "* Sauvegarde complète de $SOURCE $FAIL"
	echo -e $JAUNE
	echo "* Appuyer sur <Entrer> pour quitter..."
	read
	exit 1
}
#################################################################################
#____________________DEBUT DU SCRIPT____________________________________________#
echo -e $BLANC && clear # Change de couleur et nettoie l'affichage
test -e $USB/ # Check si le support USB est branché
if [ "$?" != "0" ]; then
	echo -e "* Accès à $USB $FAIL"
	terminer1
else
	echo -e "* Accès à $USB $OK"
fi
test -e $DIRBAK # Check si le dossier de destination existe
if [ "$?" != "0" ]; then
	mkdir $DIRBAK
		if [ "$?" != "0" ]; then
			echo -e "* mkdir "$DIRBAK" $FAIL"
			terminer1
		else
			echo -e "* mkdir "$DIRBAK" $OK"
		fi
else
	echo -e "* Accès à $DIRBAK $OK"
fi
while [ "$YESNO" = "" ]; do # Démarrage de la sauvegarde
    echo -e $JAUNE # Change de couleur avant la question
	echo -e -n "* Démarrer la sauvegarde ? (Y/N) "
	read YESNO
	echo -e $BLANC # Change de couleur après la question
	if ( [ "$YESNO" = "N" ] || [ "$YESNO" = "n" ] ); then
		echo "* Sauvegarde annulée..."
		terminer1
	elif ( [ "$YESNO" = "Y" ] || [ "$YESNO" = "y" ] ); then
		echo -e "* Chemin du log : $LOG"
		echo "* Sauvegarde en cours..."
		rsync $OPTIONS $SOURCE $DIRBAK

		if [ "$?" != "0" ]; then
			echo -e "* Sauvegarde complète de $SOURCE $FAIL"
			while [ "$LOGYESNO" = "" ]; do
				echo -e $JAUNE # Change de couleur avant la question
				echo -e -n "* Afficher le fichier log ? (Y/N) "
				read YESNOLOG
				echo -e $BLANC # Change de couleur après la question
				if ( [ "$YESNOLOG" = "N" ] || [ "$YESNOLOG" = "n" ] ); then
					clear
					terminer1
				elif ( [ "$YESNOLOG" = "Y" ] || [ "$YESNOLOG" = "y" ] ); then
					clear
					echo "* Ouverture du fichier log..."
					sleep 2 && cat $LOG
					terminer1
				else
					clear
					echo -e $JAUNE
					echo "* Répondre par <Y> ou <N>"
					echo -e $BLANC
					sleep 2 && clear
					YESNOLOG=""
				fi
			done
		else
			terminer0
		fi

	else
		clear
		echo -e $JAUNE
		echo "* Répondre par <Y> ou <N>"
		echo -e $BLANC
		sleep 2 && clear
		YESNO=""
	fi
done
