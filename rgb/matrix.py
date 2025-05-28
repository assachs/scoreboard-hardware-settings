#!/usr/bin/env -S python  -u
# Display a runtext with double-buffering.
import math
from time import sleep

import sys
import asyncio

sys.path.insert(0, '/home/pi/rpi-rgb-led-matrix/bindings/python/samples/')
sys.path.insert(0, '/home/pi/stomp_ws_py/')
sys.path.append('/home/pi/methoddispatch/')

import socket
from types import MappingProxyType
from samplebase import SampleBase
from rgbmatrix import graphics

sys.path.insert(0, '/home/pi/ably-python/')

import json
import os
import logging
import time
from threading import Thread
from scoreboardbasefunctions import *


class RunText(SampleBase):
    updatetime = 0
    pingtime = 0
    status = -1
    frame = None
    client = None

    sbf = None

    frontoffsetx = 0
    frontoffsety = 0
    backoffsetx = 192
    backoffsety = 0
    backcontent = "FULL"
    errormessage = ""

    def __init__(self, *args, **kwargs):
        super(RunText, self).__init__(*args, **kwargs)
        self.parser.add_argument("-t", "--text", help="The text to scroll on the RGB LED panel", default="Hello world!")

        self.sbf = Scoreboardbasefunctions()

        self.sbf.loadfont("saetze")
        self.sbf.loadfont("punkte")
        self.sbf.loadfont("doppelpunkt")
        self.sbf.loadfont("teamnamen")
        self.sbf.loadfont("auszeit")


    def readconfig(self):
        if os.environ['PARALLEL'] == "2":
            self.backoffsetx = 0
            self.backoffsety = 64
        if os.environ['BACK'] == "STATUS":
            self.backoffsetx = 128
            self.backcontent = "STATUS"


    def messageShow(self):
        logger.debug("Updating display")
        offscreen_canvas = self.matrix.CreateFrameCanvas()
        offscreen_canvas.Clear()

        self.draw_side_nodata(offscreen_canvas, self.frontoffsetx, self.frontoffsety)
        self.draw_side_nodata(offscreen_canvas, self.backoffsetx, self.backoffsety)
        self.draw_status(offscreen_canvas, self.backoffsetx, self.backoffsety)
        self.matrix.SwapOnVSync(offscreen_canvas)

    def draw_side_nodata(self, offscreen_canvas, offsetx, offsety):
        self.sbf.drawtextLeft(offscreen_canvas, "teamnamen", offsetx, offsety + 10, 'w', socket.gethostname())

        row = 10

        for adr in self.sbf.getAdresses():
            row = row + 10
            self.sbf.drawtextLeft(offscreen_canvas, "teamnamen", offsetx, offsety + row, 'w', adr)




    def draw_status(self, offscreen_canvas, offsetx, offsety):
        if self.status > 0:
            color = 'y'
            if self.status == 3:
                color = 'r'
            self.sbf.drawpoint(offscreen_canvas, offsetx, offsety + 63, color)

    def updateStatus(self):
        logger.debug(">updateStatus")

        changed = True

        if changed:
            self.messageShow()

    def refresh(self):
        logger.info("Refreshing start")
        loop = 0
        while True:
            logger.debug("Refreshing loop")

            if self.status == -1:
                self.updateStatus()

                sleep(1)




    def run(self):
        logger.debug(">run")
        self.readconfig()
        thread = Thread(target=self.refresh)
        thread.daemon = True
        thread.start()
        while True:
            sleep(1)



# Main function

logging.basicConfig()
logging.root.setLevel(logging.INFO)

logger = logging.getLogger(__name__)


if __name__ == "__main__":
    run_text = RunText()
    run_text.process()
    while True:
        sleep(5)


