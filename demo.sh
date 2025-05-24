#!/bin/bash
. /home/pi/scoreboard-hardware-settings/matrix.sh

export PARALLEL
export ADAPTER
export CHAINLENGTH
export BACK

timeout 10 sudo /home/pi/rpi-rgb-led-matrix/examples-api-use/demo -D4 --led-rows 64 --led-cols=64 --led-chain=$CHAINLENGTH --led-slowdown-gpio=5 --led-parallel=$PARALLEL --led-gpio-mapping=$ADAPTER  --led-multiplexing=$MULTIPLEXING --led-show-refresh

sudo -E /home/pi/scoreboard-hardware-settings/rgb/matrix.py -r 64 --led-cols 64 -c $CHAINLENGTH -P $PARALLEL --led-slowdown-gpio 5 --led-gpio-mapping=$ADAPTER --led-multiplexing=$MULTIPLEXING  --led-pwm-lsb-nanoseconds 100 --led-pwm-bits 3
