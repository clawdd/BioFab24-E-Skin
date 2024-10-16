#include <Adafruit_ADS1X15.h>
#include <SPI.h>

#define READ_PIN A6  // Define the Arduino pin A2, if you intend to read from this pin separately

Adafruit_ADS1115 ads; 

void setup(void)
{
  Serial.begin(9600);

  // Print information about ADC settings
  Serial.println("Getting single-ended readings from AIN0, AIN1, AIN2, and AIN3");
  Serial.println("ADC Range: +/- 6.144V (1 bit = 3mV/ADS1015, 0.1875mV/ADS1115)");

  // Set the gain, if needed (uncomment one of the lines below)
  // ads.setGain(GAIN_TWOTHIRDS);  // +/- 6.144V range, 1 bit = 3mV (default)
  // ads.setGain(GAIN_ONE);        // +/- 4.096V range, 1 bit = 2mV
  // ads.setGain(GAIN_TWO);        // +/- 2.048V range, 1 bit = 1mV
  // ads.setGain(GAIN_FOUR);       // +/- 1.024V range, 1 bit = 0.5mV
  // ads.setGain(GAIN_EIGHT);      // +/- 0.512V range, 1 bit = 0.25mV
  ads.setGain(GAIN_SIXTEEN);    // +/- 0.256V range, 1 bit = 0.125mV

  if (!ads.begin()) {
    Serial.println("Failed to initialize ADS.");
    while (1);  // Halt if initialization fails
  }
}

void loop(void)
{
  int16_t adc0, adc1, adc2, adc3;
  
  // Read from the four analog input channels of ADS1015
  adc0 = ads.readADC_SingleEnded(0);  // Read from AIN0
  adc1 = ads.readADC_SingleEnded(1);  // Read from AIN1
  adc2 = ads.readADC_SingleEnded(2);  // Read from AIN2
  adc3 = ads.readADC_SingleEnded(3);  // Read from AIN3
  
  // Print the ADC values for each channel
  //Serial.print("AIN0: "); 
  Serial.println(adc0);
  //Serial.print("AIN1: "); Serial.println(adc1);
  //Serial.print("AIN2: "); Serial.println(adc2);
  //Serial.print("AIN3: "); Serial.println(adc3);
  //Serial.println();

  // If you want to read from the Arduino's A2 pin (separate from ADS1015)
  // int analogValue = analogRead(READ_PIN);  // Read the value from Arduino pin A2
  // Serial.print("Arduino (Pin" +  String(READ_PIN)  + " ): "); Serial.println(analogValue);

  delay(1000);  // Wait for a second before the next reading
}