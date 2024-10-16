#include <Arduino.h>

void setup() {
  Serial.begin(9600);
}

void loop() {
  int sensorValue1 = analogRead(A6);
  int sensorValue2 = analogRead(A7);
  Serial.println(String((sensorValue1 + sensorValue2) / 2));
  delay(300);
}
