#include <Arduino.h>
#include <Muca.h>

Muca muca;

void SendRawString();

void setup() {
  Serial.begin(115200);
  // muca.skipLine(TX, (const short[]) { 1, 2, 3, 4 }, 4);
  // muca.skipLine(TX, (const short[]) { 14,15,16,17, 18, 19, 20, 21 }, 8);
  // muca.skipLine(RX,(const short[]) {11,12}, 2);
  muca.init();
  muca.useRawData(true); // If you use the raw data, the interrupt is not working

  delay(50);
  muca.setGain(2);
}

void loop() {
  if (muca.updated()) {
    SendRawString();
    // SendRawByte(); // Faster
  }
  delay(500); // waiting 16ms for 60fps
}

void SendRawString() {
  // Print the array value
  int counter = 0;
  for (int i = 0; i < NUM_TX * NUM_RX; i++) {
    if (muca.grid[i] >= 0) Serial.print(muca.grid[i]); // The +30 is to be sure it's positive
    if (i != NUM_TX * NUM_RX - 1) Serial.print(",");
    counter++;
  }
  Serial.println();
  Serial.println("############################################################################");
  Serial.println(counter);
  Serial.println("############################################################################");
}


void SendRawByte() {
  // The array is composed of 254 bytes. The two first for the minimum, the 252 others for the values.
  // HIGH byte minimum | LOW byte minimum  | value 1

  unsigned int minimum = 80000; // changed int to long since unsigned int would only allow for numbers up to 65535
  uint8_t rawByteValues[254];

  for (int i = 0; i < NUM_TX * NUM_RX; i++) {
  if (muca.grid[i] > 0 && minimum > muca.grid[i])  {
      minimum = muca.grid[i]; // The +30 is to be sure it's positive
    }
  }

  rawByteValues[0] = highByte(minimum);
  rawByteValues[1] = lowByte(minimum);

  for (int i = 0; i < NUM_TX * NUM_RX; i++) {
    rawByteValues[i + 2] = muca.grid[i] - minimum;
    // Serial.print(rawByteValues[i+2]);
    // Serial.print(",");

  }
  // Serial.println();
  // GetFPS();
  Serial.write(rawByteValues, 254);
  Serial.flush();
  // Serial.println();
}
