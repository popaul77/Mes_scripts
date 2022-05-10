#!/bin/bash
# permet d'extraire directement une archive
# peut se mettre dans le bashrc
# voir video https://youtu.be/ad1RFSwxV5o
# a partir de 10 minutes.

ex ()
{
if [ -f $1 ] ; then
  case $1 in
    *.tar.bz2)  tar xjf $1 ;;
    *.tar.gz)   tar xzf $1 ;;
    *.bz2)      bunzip2 $1 ;;
    *.rar)      unrar x $1 ;;
    *.gz)       gunzip  $1 ;;
    *.tar)      tar xf  $1 ;;
    *.tbz2)     tar xjf $1 ;;
    *.tgz)      tar xzf $1 ;;
    *.zip)      unzip   $1 ;;
    *.Z)        uncompress $1 ;;
    *.7z)       7z x    $1 ;;
    *)          echo "'$1' ne peut etre extrait par ex()" ;;
  esac
else
  echo "'$1' fichier invalide"
fi
}
