import RPi.GPIO as GPIO
from time import sleep
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-p", "--pin", type=int)
parser.add_argument("-s", "--steps", type=int)

args = parser.parse_args()

pin = args.pin
steps = args.steps

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(pin, GPIO.OUT)

for i in range(steps):
    GPIO.output(pin, False)
    sleep(0.005)
    GPIO.output(pin, True)
    sleep(0.005)
