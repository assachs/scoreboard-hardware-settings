mkdir -p /home/pi/scoreboard-hardware-settings
cp demo.sh /home/pi/scoreboard-hardware-settings

if [ ! -f /home/pi/scoreboard-hardware-settings/matrix.sh ]
then
  cp matrix.sh /home/pi/scoreboard-hardware-settings
fi