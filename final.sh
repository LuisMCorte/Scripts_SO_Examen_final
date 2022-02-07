#!/bin/bash
sudo apt-get install python3-openpyxl
sudo apt install imagemagick
mkdir cedulas #creación de directorio
 
#cambia el nombre a las fotos eliminando los espacios vacios
for f in *.png; do mv -v "$f" $(echo "$f" | tr ' ' '-'); done


#convierte la imagen a una escala de grises
for img in *.png; do convert "$img" -threshold 77% "$img"; done

#lee cada imagen para leer su contenido con tesseract
find ./ -name "*.png" | sort | while read file; do tesseract "$file" "`basename "$file" | sed 's/\.[[:alnum:]]*$//'`" -l eng -psm 3; done

#las cédulas leídas en cada imagen son validadas y enviadas a archivos de texto
for texto in $(ls *.txt)
do
        texto=$(echo "$texto")
	grep -E -o "[0-9]{10}?" "$texto" | ./validar.awk > "$texto".txt
	 mv "$texto".txt  cedulas
done

#obtiene los titulos de cada archivo de texto (fechas) y los almacena en otro archivo de texto
for i in $(ls cedulas)
do
	echo $i | egrep -o '[0-9]{4}-[0-9]{2}-[0-9]{2}' >> fechas.txt
done

python3 fin.py

rm -R cedulas
rm ./*.txt
