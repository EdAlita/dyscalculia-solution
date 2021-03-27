#include <TinyGPS.h>
#include <LiquidCrystal.h>
LiquidCrystal lcd(8,9,10,11,12,13);
TinyGPS gps;
void getgps(TinyGPS &gps);

void setup() {

  Serial.begin(9600);
  lcd.begin(16,2);

}

void getgps(TinyGPS &gps)
{
  float latitude, longitude;

  gps.f_get_position(&latitude, &longitude);
  lcd.setCursor(0, 0);
  lcd.print("Lat: ");
  lcd.print(latitude, 5);
  lcd.setCursor(0, 1);
  lcd.print("Long: ");
  lcd.print(longitude, 5);
}
void loop() {
 byte a;
 if ( Serial.available() > 0)
 {
  a = Serial.read();
  if(gps.encode(a))
  {
    getgps(gps);
  }
 }

}
