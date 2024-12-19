#include <Wire.h>

// MPU6050 Registers
const int MPU6050_ADDR = 0x68; // MPU6050 I2C address
const int ACCEL_XOUT_H = 0x3B; // Register for X-axis High byte
const int ACCEL_YOUT_H = 0x3D; // Register for Y-axis High byte

#define LED_PIN_Y 13 // LED for Y-axis connected to pin 13
#define LED_PIN_X 12 // LED for X-axis connected to pin 12

void setup() {
  Wire.begin();                // Initialize I2C communication
  Serial.begin(9600);          // Start Serial communication
  pinMode(LED_PIN_Y, OUTPUT);  // Set LED_Y pin as OUTPUT
  pinMode(LED_PIN_X, OUTPUT);  // Set LED_X pin as OUTPUT

  // Wake up MPU6050
  Wire.beginTransmission(MPU6050_ADDR);
  Wire.write(0x6B);            // Power management register
  Wire.write(0);               // Set to zero to wake up the MPU6050
  Wire.endTransmission();
}

void loop() {
  int16_t rawAccelX = readRawData(ACCEL_XOUT_H); // Read X-axis raw accelerometer value
  int16_t rawAccelY = readRawData(ACCEL_YOUT_H); // Read Y-axis raw accelerometer value

  // Map raw accelerometer values to range 100-900
  int accelX = map(rawAccelX, -1025, 1025, 100, 900);
  int accelY = map(rawAccelY, -1025, 1025, 100, 900);

  // Print mapped values to Serial Monitor
  Serial.print("Mapped X-axis Value: ");
  Serial.print(accelX);
  Serial.print(" | Mapped Y-axis Value: ");
  Serial.println(accelY);

  // Control LED for Y-axis based on tilt................................................
  if (accelY > 320) { 
    digitalWrite(LED_PIN_Y, HIGH); // Turn on LED for Y-axis
    Serial.println("Y LED ON");
  } else {
    digitalWrite(LED_PIN_Y, LOW);  // Turn off LED for Y-axis
    Serial.println("Y LED OFF");
  }

  // Control LED for X-axis based on tilt.....................................................
  if (accelX > 360) { 
    digitalWrite(LED_PIN_X, HIGH); // Turn on LED for X-axis
    Serial.println("X LED ON");
  } else {
    digitalWrite(LED_PIN_X, LOW);  // Turn off LED for X-axis
    Serial.println("X LED OFF");
  }

  delay(1000); // Small delay for stability
}

// Function to read raw accelerometer data
int16_t readRawData(int addr) {
  Wire.beginTransmission(MPU6050_ADDR);
  Wire.write(addr);
  Wire.endTransmission(false);
  Wire.requestFrom(MPU6050_ADDR, 2, true);

  int16_t highByte = Wire.read() << 8; // High byte
  int16_t lowByte = Wire.read();      // Low byte
  return highByte | lowByte;          // Combine high and low bytes
}
