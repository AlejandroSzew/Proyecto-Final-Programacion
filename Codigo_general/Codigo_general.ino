#include "I2Cdev.h"
#include "MPU6050.h"
#include "Wire.h"
#include "Wifi.h"
typedef enum { RST,
               INICIALIZACION,
               MEDICIONES,
               C_WIFI,
               ANALISIS_REP,
               ANALISIS_SERIE,
               C_APLICACION } estadoMaq_General_t;
estadoMaq_General_t estadoMaq_General = RST;
void medicionesEstandar();
void mediciones();
int msboton = 0
float ax, ay, az;
float gx, gy, gz;
IPAddress ip(10.162.4.132);
IPAddress gateway(10.162.4.132);
IPAddress subnet(255, 255, 255, 0);
WiFi.config(ip, gateway, subnet); // Static IP setup
WiFi.begin(ssid, password);

#define PIN_BOTON =
#define PIN_LED_R =
#define PIN_LED_G =
#define PIN_LED_B =
#define PIN_BOTON = 
const char* ssid = "ESP32_C3_Server";
const char* password = "GRUPO3";
WebServer server(80);

void setup() {
  pinMode(PIN_BOTON, INPUT);
  pinMode(PIN_LED_R, OUTPUT);
  pinMode(PIN_LED_G, OUTPUT);
  pinMode(PIN_LED_B, OUTPUT);
  pinMode(PIN_BOTON, INPUT_PULLUP);

  WiFi.softAP(ssid, password);
  server.begin();
  
  Serial.begin(57600);  //Iniciando puerto serial
  Wire.begin();         //Iniciando I2C
  sensor.initialize();  //Iniciando el sensor
  WiFi.softAP(ssid, password);
  IPAddress IP = WiFi.softAPIP();
   Serial.print("AP IP address: ");
  Serial.println(IP);
  server.on("/temperature", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send(200, "text/plain", readTemp().c_str());
  });
}


void loop() {
  Maq_General();
}

void Maq_General() {
  switch (estado_Maq_General) {
    case INICIALIZACION:


    case MEDICIONES:
      medicionesEstandar();
      mediciones();


    case C_WIFI:
    //datoss al sensro principal
    case ANALISIS_REP:
    //Azul
    //digitalWrite(PIN_LED_R,0);
    //digitalWrite(PIN_LED_G,0);
    //digitalWrite(PIN_LED_B,255);

    //Verde
    //digitalWrite(PIN_LED_R,0);
    //digitalWrite(PIN_LED_G,255);
    //digitalWrite(PIN_LED_B,0);

    //Rojo
    //digitalWrite(PIN_LED_R,255);
    //digitalWrite(PIN_LED_G,0);
    //digitalWrite(PIN_LED_B,0);
      if(digitalRead(PIN_BOTON == LOW){
      Serial.println("se toco el boton termino la serie);
    }
    //analizan valores, devolucion led, se guardan los errores, apreto el boton termina la serie
    case ANALISIS_SERIE:
    if(digitalRead(PIN_BOTON == LOW && msboton >= 5000){
      Serial.println("se mas de 5s, apagar sistema);
    }
    //analisis errores generales, apreto boton 5s apaga sistema
    case C_APLICACION:
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
