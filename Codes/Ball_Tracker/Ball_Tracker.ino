// Motor Pins
const int motorPin1 = 3;   // Motor A forward
const int motorPin2 = 4;   // Motor A backward
const int motorPin3 = 5;   // Motor B forward
const int motorPin4 = 6;   // Motor B backward

void setup() {
  // Initialize the serial communication at 9600 baud rate
  Serial.begin(9600);
  
  // Set motor control pins as OUTPUT
  pinMode(motorPin1, OUTPUT);
  pinMode(motorPin2, OUTPUT);
  pinMode(motorPin3, OUTPUT);
  pinMode(motorPin4, OUTPUT);
}

void loop() {
  // Check if data is available to read from the serial port
  if (Serial.available() > 0) {
    char incomingByte = Serial.read();  // Read the incoming byte
    
    // Perform actions based on the received character
    if (incomingByte == 'F') {
      // Move forward: Motors A and B forward
      digitalWrite(motorPin1, HIGH);
      digitalWrite(motorPin2, LOW);
      digitalWrite(motorPin3, HIGH);
      digitalWrite(motorPin4, LOW);
      Serial.println("Moving Forward");
    } 
    else if (incomingByte == 'B') {
      // Move backward: Motors A and B backward
      digitalWrite(motorPin1, LOW);
      digitalWrite(motorPin2, HIGH);
      digitalWrite(motorPin3, LOW);
      digitalWrite(motorPin4, HIGH);
      Serial.println("Moving Backward");
    }
    else if (incomingByte == 'L') {
      // Turn left: Motor A forward, Motor B backward
      digitalWrite(motorPin1, HIGH);
      digitalWrite(motorPin2, LOW);
      digitalWrite(motorPin3, LOW);
      digitalWrite(motorPin4, HIGH);
      Serial.println("Turning Left");
    }
    else if (incomingByte == 'R') {
      // Turn right: Motor A backward, Motor B forward
      digitalWrite(motorPin1, LOW);
      digitalWrite(motorPin2, HIGH);
      digitalWrite(motorPin3, HIGH);
      digitalWrite(motorPin4, LOW);
      Serial.println("Turning Right");
    }
    else if (incomingByte == 'S') {
      // Stop: Stop all motors
      digitalWrite(motorPin1, LOW);
      digitalWrite(motorPin2, LOW);
      digitalWrite(motorPin3, LOW);
      digitalWrite(motorPin4, LOW);
      Serial.println("Stopping");
    }
    else {
      Serial.println("Invalid command received");
    }
  }
}
