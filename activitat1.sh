#!/bin/bash

# Eliminem possibles dades anteriors
rm -rf backup_data
rm -rf backup_data_recovery
rm -f compressed_data.zip
rm -f hashes_originals.txt
rm -f hashes_recovery.txt

# Creem el directori principal
mkdir backup_data

# Creem els fitxers
touch backup_data/fitxer1.txt
touch backup_data/fitxer2.txt
touch backup_data/fitxer3.txt

# Afegim contingut diferent
echo "bon dia" > backup_data/fitxer1.txt
echo "bona tarda" > backup_data/fitxer2.txt
echo "bona nit" > backup_data/fitxer3.txt

echo "Fitxers creats correctament"

# Generem hashes originals
sha256sum backup_data/* > hashes_originals.txt

echo "Hashes originals guardats"

# Comprimim i xifrem amb contrasenya
zip -rqP 1234 compressed_data.zip backup_data/

echo "Arxiu comprimit i protegit"

# Intent d'accedir sense contrasenya
echo "Provant accés sense credencials..."

unzip -t compressed_data.zip > /dev/null

echo "Sense contrasenya correcta no es pot accedir al contingut"

# Descomprimim el contingut
unzip -P 1234 compressed_data.zip > /dev/null

# Renombrem directori recuperat
mkdir backup_data_recovery

unzip -P 1234 compressed_data.zip -d backup_data_recovery > /dev/null

echo "Contingut recuperat"

# Simulem manipulació
echo "bones tardes" > backup_data_recovery/backup_data/fitxer2.txt
echo "Manipulació simulada"

# Generem hashes dels fitxers recuperats
sha256sum backup_data_recovery/* > hashes_recovery.txt

echo "Comparant hashes..."

# Detectem modificacions
while read linea
do
    hash_original=$(echo $linea | cut -d " " -f1)
    fitxer=$(echo $linea | cut -d " " -f3)

    hash_nou=$(grep "$fitxer" hashes_recovery.txt | cut -d " " -f1)

    if [ "$hash_original" != "$hash_nou" ]
    then
        echo ""
        echo "ALERTA: El fitxer $fitxer ha estat modificat"
        echo "Mostrant diferències:"
        echo ""

        diff backup_data/$fitxer backup_data_recovery/backup_data/$fitxer    
    fi

done < hashes_originals.txt