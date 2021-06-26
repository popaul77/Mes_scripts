#!/bin/bash
# produced by GG

# pour etre sur que tous les fichiers soit bien en jpg
# on utilise rename (apt install rename).
rename 's/\.jpe?g$/.jpg/i' *

convert *.jpg $DIR/livret.pdf
#réduire le poids du pdf
gs -sDEVICE=pdfwrite -dPDFSETTINGS=/screen -dNOPAUSE -dBATCH -sOutputFile=$DIR/livret_comp.pdf $DIR/livret.pdf
# suprime le pdf non compressé
rm livret.pdf

####################################################################################
# tout ça en une seule lignepour ariel
#### uniquement pour le fun.
# rename 's/\.jpe?g$/.jpg/i' *; convert *.jpg $DIR/livret.pdf; gs -sDEVICE=pdfwrite -dPDFSETTINGS=/screen -dNOPAUSE -dBATCH -sOutputFile=$DIR/livret_comp.pdf $DIR/livret.pdf; rm livret.pdf

#######################################################################################

# On peut utiliser des options avec dPDFSETTINGS
# -dPDFSETTINGS Option	Description
#-dPDFSETTINGS=/screen	Has a lower quality and smaller size. (72 dpi)
#-dPDFSETTINGS=/ebook	Has a better quality, but has a slightly larger size ( 150 dpi)
#-dPDFSETTINGS=/prepress	Output is of a higher size and quality (300 dpi)
#-dPDFSETTINGS=/printer	Output is of a printer type quality (300 dpi)
#-dPDFSETTINGS=/default	Selects the output which is useful for multiple purposes. Can cause large PDFS.
