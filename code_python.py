# Import required Python libraries
import time
import RPi.GPIO as GPIO
import datetime
from subprocess import call

# Use BCM GPIO references
# instead of physical pin numbers
GPIO.setmode(GPIO.BCM)

# A couple of variables Define GPIO to use on Pi ---------------------
GPIO_TRIGGER = 23
EXIT = 0 # Infinite loop
GPIO_ECHO = 24
lastdistance = 0.0
sensitivity = 10 #sensitivity %

# Set pins as output and input
GPIO.setup(GPIO_TRIGGER,GPIO.OUT)  # Trigger
GPIO.setup(GPIO_ECHO,GPIO.IN)      # Echo

# Set trigger to False (Low)
GPIO.output(GPIO_TRIGGER, False)

# Allow module to settle
time.sleep(0.5)

# Send 10us pulse to trigger
def measure():
  GPIO.output(GPIO_TRIGGER, True)
  time.sleep(0.00001)
  GPIO.output(GPIO_TRIGGER, False)
  start = time.time()

  while GPIO.input(GPIO_ECHO)==0:
    start = time.time()

  while GPIO.input(GPIO_ECHO)==1:
    stop = time.time()
  # Calculate pulse length
  elapsed = stop-start

  # Distance pulse travelled in that time is time
  # multiplied by the speed of sound (cm/s)
  distance = elapsed * 34300

  # That was the distance there and back so halve the value
  distance = distance / 2

  #print "Distance : %.1f" % distance
  return distance

def measure_average():
  count = 1
  # Reset GPIO settings GPIO.cleanup()
  distance = 0
  while ( count <= 3 ):
    distance = distance + measure()
    time.sleep(0.1)
    count = count + 1
  distance = distance / 3
  return distance

try:
  # Never ending loop -----------------
  while EXIT == 0:
    distance = measure_average()
    if lastdistance <> 0.0:
      minDiff = lastdistance * (100 - sensitivity) / 100
      maxDiff = lastdistance * (100 + sensitivity) / 100
      if distance < minDiff or distance > maxDiff:
        print "on prend une photo"
        t = datetime.datetime.now()
        timeStr = t.strftime('%Y%m%d-%H%M%S')
        call (["raspistill -o image_"+timeStr+".jpg -t 100"], shell=True)
        time.sleep(0.2)
    print "distance : %.1f" % distance
    print "last distance : %.1f" % lastdistance
    lastdistance = distance

except KeyboardInterrupt:
  # Reset GPIO settings
  GPIO.cleanup()