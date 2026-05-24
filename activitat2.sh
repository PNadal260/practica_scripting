#!/bin/bash

echo "CONFIGURACIÓ SERVIDOR SSH"

# Instal·lar servidor SSH
echo ""
echo "Instal·lant openssh-server..."

sudo apt update
sudo apt install -y openssh-server

# Activar servei SSH
echo ""
echo "Activant servei SSH..."

sudo systemctl enable ssh
sudo systemctl start ssh

# Comprovar estat
echo ""
echo "Estat del servei SSH:"
sudo systemctl status ssh --no-pager

# Generar claus RSA
echo ""
echo "Generant claus RSA..."

ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""

# Configurar accés sense contrasenya
echo ""
echo "Configurant autenticació sense contrasenya..."

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

echo ""
echo "Provant connexió SSH local..."

ssh localhost "echo Connexio SSH correcta"

# Crear fitxer de prova
echo ""
echo "Creant fitxer de prova..."

echo "Aquest es un fitxer transferit amb SCP" > prova.txt

# Crear directori destí
mkdir -p copia_ssh

# Transferència amb SCP
echo ""
echo "Transferint fitxer amb SCP..."

scp prova.txt localhost:~/copia_ssh/

# Comprovar còpia
echo ""
echo "Contingut del directori copia_ssh:"
ls ~/copia_ssh/

# Transferència amb RSYNC
echo ""
echo "Transferint fitxer amb RSYNC..."

mkdir -p copia_rsync

rsync -av prova.txt localhost:~/copia_rsync/

# Comprovar còpia
echo ""
echo "Contingut del directori copia_rsync:"
ls ~/copia_rsync/

echo ""
echo "PROCÉS FINALITZAT"