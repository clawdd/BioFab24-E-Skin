#include <Arduino.h>

void setup() {
  Serial.begin(9600);  // Start the serial communication to view results
}

void loop() {
  int sensorValue = analogRead(A6);  // Read the voltage on pin A6
  Serial.println(sensorValue);  // Print the voltage value
  delay(300);  // Delay for 1 second between readings
}
