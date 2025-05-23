mkdir -p /home/pi/scoreboard-hardware-settings
cp scoreboard-hardware-settings-temp/demo.sh /home/pi/scoreboard-hardware-settings
chmod 755 /home/pi/scoreboard-hardware-settings/demo.sh
if [ ! -f /home/pi/scoreboard-hardware-settings/matrix.sh ]
then
  cp scoreboard-hardware-settings-temp/matrix.sh /home/pi/scoreboard-hardware-settings
fi

sudo cp /home/pi/scoreboard-hardware-settings-temp/matrix.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable matrix.service