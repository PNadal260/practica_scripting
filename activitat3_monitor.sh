#!/bin/bash

LOG="monitor.log"

echo "Monitor iniciat..." >> $LOG

while true
do
    # Obtener uso de CPU
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}')
    # Comprobar límite
    if [ "$CPU" -gt 20 ]
    then
        echo "ALERTA: Ús de CPU alt -> $CPU%" 

        echo "$(date) - ALERTA: CPU al $CPU%" >> $LOG
    fi

    sleep 2
done