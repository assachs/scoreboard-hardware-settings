mkdir -p /home/pi/scoreboard-hardware-settings
cp scoreboard-hardware-settings-temp/demo.sh /home/pi/scoreboard-hardware-settings
cp -r scoreboard-hardware-settings-temp/rgb /home/pi/scoreboard-hardware-settings
chmod 755 /home/pi/scoreboard-hardware-settings/demo.sh
chmod 755 /home/pi/scoreboard-hardware-settings/rgb/matrix.py
if [ ! -f /home/pi/scoreboard-hardware-settings/matrix.sh ]
then
  cp scoreboard-hardware-settings-temp/matrix.sh /home/pi/scoreboard-hardware-settings
fi
sudo apt install python3-netifaces
sudo apt install fonts-freefont-otf python3-websocket otf2bdf

sudo cp /home/pi/scoreboard-hardware-settings-temp/matrix.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable matrix.service

cd ~/rpi-rgb-led-matrix/fonts/

otf2bdf -v -o FreeSans-36-20.bdf -r 36 -p 20 /usr/share/fonts/opentype/freefont/FreeSans.otf
otf2bdf -v -o FreeSans-72-30.bdf -r 72 -p 30 /usr/share/fonts/opentype/freefont/FreeSans.otf
otf2bdf -v -o FreeSans-72-66.bdf -r 72 -p 66 /usr/share/fonts/opentype/freefont/FreeSans.otf
otf2bdf -v -o FreeSans-72-66.bold.bdf -r 72 -p 66 /usr/share/fonts/opentype/freefont/FreeSansBold.otf

ln -s FreeSans-72-30.bdf saetze.bdf
ln -s FreeSans-72-66.bold.bdf punkte.bdf
ln -s FreeSans-72-66.bdf doppelpunkt.bdf
ln -s FreeSans-36-20.bdf teamnamen.bdf
ln -s FreeSans-36-20.bdf auszeit.bdf

cd ~