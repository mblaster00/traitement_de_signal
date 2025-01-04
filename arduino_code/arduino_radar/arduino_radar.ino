 #include <Servo.h> 
#define TRIGGER_PIN  A0 // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     A1  // Arduino pin tied to echo pin on the ultrasonic sensor.
// definir le temps et la distance 
long duration;
int distance;
Servo myServo; // Object servo
void setup() {
  pinMode(TRIGGER_PIN, OUTPUT); // trigPin as an Output
  pinMode(ECHO_PIN, INPUT); // echoPin as an Input
  Serial.begin(9600);
  myServo.attach(10); // Pin Connected To Servo
}
void loop() {
  // rotating servo i++ depicts increment of one degree
  for(int i=15;i<=165;i++){  
  myServo.write(i);
  delay(30);
  distance = calculateDistance();
  Serial.println(i);  //angle in degrees
  Serial.println(distance); // in cm 
  Serial.println(".");
  }
  // Repeats the previous lines from 165 to 15 degrees
  for(int i=165;i>15;i--){  
  myServo.write(i);
  delay(30);
  distance = calculateDistance();
  Serial.println(i);
  Serial.println(distance);
  Serial.println(".");
  }
}
int calculateDistance(){ 
  
  digitalWrite(TRIGGER_PIN, LOW); 
  delayMicroseconds(2);
  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(TRIGGER_PIN, HIGH); 
  delayMicroseconds(5);
  digitalWrite(TRIGGER_PIN, LOW);
  duration = pulseIn(ECHO_PIN, HIGH); 
  distance= duration*0.034/2;
  return distance;
}
