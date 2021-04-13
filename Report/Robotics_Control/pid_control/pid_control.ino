#define sensorPin 14
#define motorPin 7
#define desireAnglePin 8

float errorP, errorI, errorD;
float errorB;
float output;
// PID params
float Kp, Ki, Kd;
float pidVal;

void setup() {
  // baud rate = 9600;
  Serial.begin(9600);
}
void loop() {
  // get error between desire angle and the actual
  // cycle = subtract (18) + analogRead(5)*2 + assignment operator (4) = 32
  errorP = analogRead(desireAnglePin) - analogRead(sensorPin); 
  // add up the error I control
  // cycle = add (18) + assignment operator (4) = 22
  errorI += errorP;
  // minus the error D control
  // cycle = subtract (18) + assignment operator (4) = 22
  errorD = errorB-errorP;
  // write previous error for future reference.
  // cycle = assignment operator (4) = 4
  errorB = errorP;
  // cycle = add (18)*2 + multiply(18)*3 + assignment operator (4) = 94
  pidVal=errorP*Kp+errorI*Ki+errorD*Kd;
  // write the voltage to the output pin.
  // cycle = analogWrite(6) = 6
  analogWrite(motorPin,pidVal);
}
