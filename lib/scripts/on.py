import RPi.GPIO as GPIO
from time import sleep
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-p", "--pin", type=int)

args = parser.parse_args()
pin = args.pin

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(pin, GPIO.OUT)
GPIO.output(pin, True)
GPIO.cleanup()
