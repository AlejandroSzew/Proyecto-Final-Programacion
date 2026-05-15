#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_ADXL345_U.h>

// Crear objeto del sensor
Adafruit_ADXL345_Unified accel = Adafruit_ADXL345_Unified(12345);

void setup() {
  Serial.begin(115200);
  Wire.begin();

  if (!accel.begin()) {
    Serial.println("Error al conectar el ADXL345");
    while (1);
  }
  Serial.println("ADXL345 conectado correctamente");

  // Configurar rango de medida
  accel.setRange(ADXL345_RANGE_2_G);  // ±2g
}

void loop() {
  sensors_event_t event;
  accel.getEvent(&event);

  // Lectura en m/s² directamente
  float ax_ms2 = event.acceleration.x;
  float ay_ms2 = event.acceleration.y;
  float az_ms2 = event.acceleration.z;

  Serial.print("Accel (m/s²): ");
  Serial.print(ax_ms2); Serial.print(", ");
  Serial.print(ay_ms2); Serial.print(", ");
  Serial.println(az_ms2);

  Serial.println("-----------------------------");
  delay(1000);
}
