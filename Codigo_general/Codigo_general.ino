#include "I2Cdev.h"
#include "MPU6050.h"
#include "Wire.h"
typedef enum { RST,
               INICIALIZACION,
               MEDICIONES,
               C_WIFI,
               ANALISIS_REP,
               ANALISIS_SERIE,
               C_APLICACION } estadoMaq_General_t;
estadoMaq_General_t estadoMaq_General = RST;

int ax, ay, az;
int gx, gy, gz;
#define PIN_BOTON = 
#define PIN_LED_R =
#define PIN_LED_G =
#define PIN_LED_B = 

void setup() {
  pinMode(PIN_BOTON,INPUT);
  pinMode(PIN_LED_R, OUTPUT);
  pinMode(PIN_LED_G, OUTPUT);
  pinMode(PIN_LED_B, OUTPUT);
  
  Serial.begin(57600);  //Iniciando puerto serial
  Wire.begin();         //Iniciando I2C
  sensor.initialize();  //Iniciando el sensor
  
  if (sensor.testConnection()) { Serial.println("Sensor iniciado correctamente"); }
  else { Serial.println("Error al iniciar el sensor"); }
}


void loop() {
  Maq_General();
}

void Maq_General() {
  switch (estado_Maq_General) {
    case INICIALIZACION:


    case MEDICIONES:
    sensor.getAcceleration(&ax, &ay, &az); //aceleracion del sensor en x, y, z
    sensor.getRotation(&gx, &gy, &gz); //angulo del sensor en x, y, z

    case C_WIFI:
    case ANALISIS_REP:
    case ANALISIS_SERIE:
    case C_APLICACION:
  }
}