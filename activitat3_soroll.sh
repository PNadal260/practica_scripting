#!/bin/bash

echo "Generant càrrega de CPU..."

for i in {1..4}
do
    yes > /dev/null &
done

sleep 15

echo "Aturant processos..."

pkill yes

echo "Soroll finalitzat"