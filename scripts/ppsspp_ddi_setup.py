from time import sleep
import platform
from pynput.keyboard import Controller, Key
import os, sys

k = Controller()

# Focus window
if platform.system() == "Windows" or platform.system() == "MacOS":
	#untested...
	import pygetwindow as gw
	w = gw.getWindowsWithTitle('UCJS10002 : どこでもいっしょ')[0]
	w.activate()
else: # Assume Linux/*BSD/whatever
	os.system('wmctrl -xa "ppsspp"')

# Delayed tap for the in-game keyboard
def qtap(key, delay = 0.03):
	k.press(key);
	sleep(delay);
	k.release(key);

print("Sleeping for .5 seconds...")
sleep(.5)

tsn = .16
ttsn = .13

try:
	if sys.argv[1] == "reset":
		qtap(Key.esc)
		sleep(.1)
		qtap(Key.right)
		qtap(Key.down,.7)
		qtap(Key.enter);
		qtap(Key.down,.3)
		qtap(Key.down,.01)
		qtap(Key.down,.01)
		qtap(Key.down)
		qtap(Key.down)
		qtap(Key.enter)
		sleep(1)
except:
	pass

qtap('`', .5)
#k.tap(Key.esc)
sleep(ttsn)
qtap('x')
sleep(ttsn)
qtap('x')
sleep(tsn)
qtap('a')
sleep(tsn)
qtap('x')
sleep(tsn)
qtap('x')
sleep(tsn)
qtap('x')
sleep(tsn)
qtap('a')
sleep(tsn)
qtap('x')
sleep(tsn)

qtap('x')
sleep(ttsn)
qtap('x')
sleep(ttsn)
qtap('x')
sleep(ttsn)
qtap('x')
sleep(ttsn)
qtap('x')
sleep(ttsn)
qtap('x')
sleep(tsn)
qtap('a')
sleep(tsn)
qtap('x')
sleep(tsn)
qtap('x')
