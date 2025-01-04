#include <Servo.h> 
#include <NewPing.h>

#define TRIGGER_PIN  A0 // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     A1  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 25 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.
Servo myservo;  // create servo object to control a servo 
// a maximum of eight servo objects can be created 

int pos = 23;
int distance = 0;
int stepsize = 4;

int detect = 0;


void setup() {
  Serial.begin(115200); // Open serial monitor at 115200 baud to see ping results.
  myservo.attach(10);  // attaches the servo on pin 10 to the servo object 
  myservo.write(pos); 

}
void loop() {
 
  delay(30);                      // Wait 50ms between pings (about 20 pings/sec). 29ms should be the shortest delay between pings.
  unsigned int uS = sonar.ping(); 
  // Send ping, get ping time in microseconds (uS).
  distance = uS / US_ROUNDTRIP_CM;

  if (distance <= 4) { 
    // nothing detected
    detect = 0;
    // move left
    pos = pos + stepsize;
    myservo.write(pos);
    if (pos > 200){
      pos = 200;
    }
  }
  else {
    // something is detected
    detect = 1;
    // move right
    pos = pos - stepsize;
    myservo.write(pos);
    if (pos < 20) {
      pos = 20;
      }
  
      

  
    }
    Serial.println(distance);
}
