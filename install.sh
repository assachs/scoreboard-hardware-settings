mkdir -p /home/pi/scoreboard-hardware-settings
cp scoreboard-hardware-settings-temp/demo.sh /home/pi/scoreboard-hardware-settings

if [ ! -f /home/pi/scoreboard-hardware-settings/matrix.sh ]
then
  cp scoreboard-hardware-settings-temp/matrix.sh /home/pi/scoreboard-hardware-settings
fi