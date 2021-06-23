#! /bin/bash
for i in *.jpg
	do
			convert -compress jpeg $i $i.pdf
			pdf2ps $i.pdf; ps2pdf $i.ps $i.pdf; rm $i.ps
	done

pdftk *.pdf cat output Mon_Album.pdf
rm *.jpg.pdf
echo -e "==========> TERMINÉ ! "
