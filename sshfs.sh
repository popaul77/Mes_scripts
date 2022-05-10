#!/usr/bin/env bash

Destination_1=$HOME/Raspi-1-hdd1
Destination_2=$HOME/Raspi-1-hdd2
Destination_3=$HOME/Raspi-1-hdd3
#Destination_Zaclys=/home/jpg/Zaclys_clef
Serveur=192.168.1.251


function reseau()
{
  ping -c1 $Serveur >/dev/null

  if [[ ! $? = "0" ]]; then
    echo "Pas de connexion reseau avec le serveur"
    exit 1
  fi
}



function montage ()
{
  sshfs pi@raspi-1:hdd1 $Destination_1/
    if [[ ! $? = "0" ]]; then
      echo "Impossible de monter le disque hdd1"
    fi
  sshfs pi@raspi-1:hdd2 $Destination_2/
    if [[ ! $? = "0" ]]; then
      echo "Impossible de monter le disque hdd2"
    fi
  sshfs pi@raspi-1:hdd3 $Destination_3/
    if [[ ! $? = "0" ]]; then
      echo "Impossible de monter le disque hdd3"
    fi

#  sshfs monlogin@sshfs.zaclys.com:/zclef     $Destination_Zaclys/
#   if [[ ! $? = "0" ]]; then
#      echo "Impossible de monter le disque Zaclys_clef"
#    fi
}

# il faut verifier que le disque est bien dans /etc/mtab avant de le demonter
# il faut verifier qu'il n'est plus utilisé.
function demontage ()
{
  fusermount -u $Destination_1/
  fusermount -u $Destination_2/
  fusermount -u $Destination_3/
#  fusermount -u $Destination_Zaclys/
}

if [[ $1 = "-u" ]]; then
  reseau
  demontage
  #echo "demontage des disques hdd1, hdd2 et Zaclys_clef"

else
  reseau
  montage
  #echo "montage des disques hdd1, hdd2 et zaclys_clef"
fi
