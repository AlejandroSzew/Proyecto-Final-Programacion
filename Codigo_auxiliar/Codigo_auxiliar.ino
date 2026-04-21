#include "I2Cdev.h"
#include "MPU6050.h"
#include "Wire.h"
#include "Wifi.h"
typedef enum { RST,
               INICIALIZACION,
               MEDICIONES,
               C_WIFI,
               } estadoMaq_Auxiliar_t;
estadoMaq_Auxiliar_t estadoMaq_Auxiliar = RST;
void medicionesEstandar();
void mediciones();

float ax, ay, az;
float gx, gy, gz;


const char* ssid = "ESP32_C3_Server";
const char* password = "GRUPO3";
WebServer server(80);

void setup() {

  server.begin();
  Serial.begin(57600);  //Iniciando puerto serial
  Wire.begin();         //Iniciando I2C
  sensor.initialize();  //Iniciando el sensor
  WiFi.softAP(ssid, password);
  IPAddress ip = Wifi.soft if (sensor.testConnection()) {
    Serial.println("Sensor iniciado correctamente");
  }
  else {
    Serial.println("Error al iniciar el sensor");
  }
}


void loop() {
  Maq_Auxiliar();
}

void Maq_Auxiliar() {
  switch (estado_Maq_Auxiliar) {
    case INICIALIZACION:


    case MEDICIONES:
      medicionesEstandar();
      mediciones();


    case C_WIFI:
    //datoss al sensro principal por wifi
    

  }
}


void medicionesEstandar() {
  sensor.getAcceleration(&ax, &ay, &az);  //aceleracion del sensor en x, y, z
  sensor.getRotation(&gx, &gy, &gz);      //angulo del sensor en x, y, z
  int valores_estandar_ax = ax * 9.81;
  int valores_estandar_ay = ay * 9.81;
  int valores_estandar_az = az * 9.81;

  int valores_estandar_gx = gx int valores_estandar_gy = gy int valores_estandar_gz = gz
  Serial.println("valor estandar ax en (m/s^2)", valores_estandar_ax);
  Serial.println("valor estandar ay en (m/s^2)", valores_estandar_ay);
  Serial.println("valor estandar az en (m/s^2)", valores_estandar_az);

  Serial.println("valor estandar gx en (°/s)", valores_estandar_gx);
  Serial.println("valor estandar gy  en (°/s)", valores_estandar_gy);
  Serial.println("valor estandar gz en (°/s)", valores_estandar_gz);
}

void mediciones() {
  sensor.getAcceleration(&ax, &ay, &az);  //aceleracion del sensor en x, y, z
  sensor.getRotation(&gx, &gy, &gz);      //angulo del sensor en x, y, z
  float valores_ax = ax * 9.81;
  float valores_ay = ay * 9.81;
  float valores_az = az * 9.81;

  float valores_gx = gx;
  float valores_gy = gy;
  float valores_gz = gz;
/*float diff_ax = valores_ax - valores_estandar_ax;
float  diff_ay = valores_ay - valores_estandar_ay;
float  diff_az = valores_az - valores_estandar_az;

float  diff_gx = valores_gx - valores_estandar_gx;
float  diff_gy = valores_gy -  valores_estandar_gx;
float  diff_gz = valores_gz -  valores_estandar_gx;
*/
  Serial.println("valores ax en (m/s^2)", valores_ax);
  Serial.println("valor  ay en (m/s^2)", valores_ay);
  Serial.println("valor  az en (m/s^2)", valores_az);

  Serial.println("valor  gx en (°/s)", valores_gx);
  Serial.println("valor  gy  en (°/s)", valores_gy);
  Serial.println("valor  gz en (°/s)", valores_gz);
} 