#!/bin/bash
rm -r backup_data
rm backup_data.zip

mkdir backup_data

touch backup_data/fitxer1.txt backup_data/fitxer2.txt backup_data/fitxer3.txt

echo "bon dia" >> backup_data/fitxer1.txt
echo "bona tarda" >> backup_data/fitxer2.txt
echo "bona nit" >> backup_data/fitxer3.txt

zip -rqP 1234 compressed_data.zip backup_data/

unzip compressed_data.zip
mv compressed_data backup_data_recovery
echo buenas tardes > backup_data_recovery/fitxer2.txt

