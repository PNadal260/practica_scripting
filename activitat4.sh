#!/bin/bash

echo "===== CONSULTA API GITHUB ====="

# Comprovar dependències
if ! command -v curl &> /dev/null
then
    echo "curl no està instal·lat"
    exit
fi

if ! command -v jq &> /dev/null
then
    echo "jq no està instal·lat"
    exit
fi

# Demanar dades
echo ""
read -p "Nom del propietari: " owner
read -p "Nom del repositori: " repo

# Construir URL
url="https://api.github.com/repos/$owner/$repo"

echo ""
echo "Consultant API..."

# Desar resposta JSON
curl -s $url > resposta.json

# Comprovar si existeix el repositori
error=$(jq -r '.message' resposta.json)

if [ "$error" = "Not Found" ]
then
    echo "Repositori no trobat"
    exit
fi

echo "Resposta guardada a resposta.json"

# Extreure dades
full_name=$(jq -r '.full_name' resposta.json)
description=$(jq -r '.description' resposta.json)
language=$(jq -r '.language' resposta.json)
stars=$(jq -r '.stargazers_count' resposta.json)
forks=$(jq -r '.forks_count' resposta.json)
issues=$(jq -r '.open_issues_count' resposta.json)
updated=$(jq -r '.updated_at' resposta.json)

# Mostrar informació
echo ""
echo "===== INFORMACIÓ DEL REPOSITORI ====="

echo "Nom complet: $full_name"
echo "Descripció: $description"
echo "Llenguatge principal: $language"
echo "Estrelles: $stars"
echo "Forks: $forks"
echo "Issues obertes: $issues"
echo "Última actualització: $updated"

# Filtre
echo ""
echo "===== FILTRE ====="
echo "1. Repositoris amb més de X estrelles"
echo "2. Mostrar només si usa un llenguatge concret"

read -p "Escull una opció: " opcio

if [ "$opcio" = "1" ]
then
    read -p "Número mínim d'estrelles: " minim

    if [ "$stars" -ge "$minim" ]
    then
        resultat="El repositori compleix el filtre d'estrelles"
    else
        resultat="El repositori NO compleix el filtre d'estrelles"
    fi

elif [ "$opcio" = "2" ]
then
    read -p "Llenguatge a cercar: " lleng

    if [ "$language" = "$lleng" ]
    then
        resultat="El repositori utilitza el llenguatge indicat"
    else
        resultat="El repositori NO utilitza el llenguatge indicat"
    fi

else
    resultat="Opció no vàlida"
fi

echo ""
echo "$resultat"

# Guardar resultats
echo "===== RESULTATS =====" > resultat.txt
echo "Nom complet: $full_name" >> resultat.txt
echo "Descripció: $description" >> resultat.txt
echo "Llenguatge: $language" >> resultat.txt
echo "Estrelles: $stars" >> resultat.txt
echo "Forks: $forks" >> resultat.txt
echo "Issues: $issues" >> resultat.txt
echo "Última actualització: $updated" >> resultat.txt
echo "Filtre: $resultat" >> resultat.txt

echo ""
echo "Resultats guardats a resultat.txt"