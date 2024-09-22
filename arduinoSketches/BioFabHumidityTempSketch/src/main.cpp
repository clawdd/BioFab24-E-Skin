#include <Arduino.h>

void setup() {
  Serial.begin(9600);  // Start the serial communication to view results
}

void loop() {
  int sensorValue1 = analogRead(A6);  // Read the voltage on pin A6
  int sensorValue2 = analogRead(A7);
  Serial.println(String((sensorValue1 + sensorValue2) / 2));
  delay(300);  // Delay for 1 second between readings
}
