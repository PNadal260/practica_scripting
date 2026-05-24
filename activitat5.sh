#!/bin/bash

# =========================
# SCRIPT DE MANTENIMENT
# =========================

# Directori de treball
mkdir -p automatitzacio/backups

LOG="automatitzacio/manteniment.log"
HASHFILE="automatitzacio/hashes.txt"

echo ""
read -p "Introdueix el directori a copiar: " origen

# Comprovar si existeix
if [ ! -d "$origen" ]
then
    echo "ERROR: El directori no existeix"

    echo "$(date) - ERROR: Directori inexistent -> $origen" >> $LOG

    exit
fi

# Generar data
data=$(date +"%Y%m%d_%H%M%S")

# Nom backup
backup="automatitzacio/backups/backup_$data.tar.gz"

echo ""
echo "Creant backup..."

# Crear backup comprimit
tar -czf $backup $origen 2>> $LOG

# Comprovar si s'ha creat
if [ ! -f "$backup" ]
then
    echo "ERROR: No s'ha pogut crear el backup"

    echo "$(date) - ERROR creant backup" >> $LOG

    exit
fi

echo "Backup creat correctament"

# Calcular hash
hash=$(sha256sum $backup)

# Guardar hash
echo "$hash" >> $HASHFILE

echo "Hash guardat"

# Escriure log
echo "$(date) - Backup creat: $backup" >> $LOG

echo ""
echo "Procés completat correctament"