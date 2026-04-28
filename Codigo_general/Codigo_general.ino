#include "I2Cdev.h"
#include "MPU6050.h"
#include "Wire.h"
#include "Wifi.h"
#include "ESPAsyncWebServer.h"
#include "BluetoothSerial.h"



BluetoothSerial SerialBT;

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
int msboton = 0 float ax, ay, az;
float gx, gy, gz;

IPAddress ip(10.162.4.132);
IPAddress gateway(10.162.4.132);
IPAddress subnet(255, 255, 255, 0);
WiFi.config(ip, gateway, subnet);  // Static IP setup
WiFi.begin(ssid, password);

#define PIN_BOTON =
#define PIN_LED_R =
#define PIN_LED_G =
#define PIN_LED_B =
#define PIN_BOTON =
const char* ssid = "MECA-IoT";
const char* password = "IoT$2026;
AsyncWebServer server(80);

void setup() {
  SerialBT.begin("ESP32_CLASSIC_BT"); //Bluetooth device name
  Serial.println("The device started, now you can pair it with bluetooth!");
  pinMode(PIN_BOTON, INPUT);
  pinMode(PIN_LED_R, OUTPUT);
  pinMode(PIN_LED_G, OUTPUT);
  pinMode(PIN_LED_B, OUTPUT);
  pinMode(PIN_BOTON, INPUT_PULLUP);
  Serial.begin(57600);  //Iniciando puerto serial
  Wire.begin();         //Iniciando I2C
  sensor.initialize();  //Iniciando el sensor

  WiFi.softAP(ssid, password);
  server.begin();
  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP);
}


void loop() {
  Maq_General();
}

void Maq_General() {
  switch (estado_Maq_General) {
    case INICIALIZACION:
    break;

    case MEDICIONES:
      medicionesEstandar();
      mediciones();


    case C_WIFI:
    server.on("ax", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send(200, "text/plain", readPres().c_str());
  });
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
      break;
    }
    
    case ANALISIS_SERIE:
    if(digitalRead(PIN_BOTON == LOW && msboton >= 5000){
      Serial.println("se mas de 5s, apagar sistema);
    }
    break;
    //analisis errores generales, apreto boton 5s apaga sistema
    case C_APLICACION:
    SerialBT.write(data);
  }
}

void medicionesEstandar() {

float est_ax = 0.0;   // m/s²
float est_ay = 9.81;  // m/s²
float est_az = 0.0;   // m/s²

float est_inclX = 0.0;  // grados
float est_inclY = 0.0;  // grados
float est_inclZ = 90.0; // grados
  // Margen de tolerancia
  float tol_acc = 2.0;   // ±2 m/s²
  float tol_incl = 5.0;  // ±5 grados
  // Comparación eje por eje
  if ((ax_ms2 - est_ax) > tol_acc) {
    Serial.println("Error en aceleración eje X");
  }
  if ( (ay_ms2 - est_ay) > tol_acc) {
    Serial.println("Error en aceleración eje Y");
  }
  if ((az_ms2 - est_az) > tol_acc) {
    Serial.println("Error en aceleración eje Z");
  }

  if ((inclX - est_inclX) > tol_incl) {
    Serial.println("Error en inclinación eje X");
  }
  if ((inclY - est_inclY) > tol_incl) {
    Serial.println("Error en inclinación eje Y");
  }
  if ((inclZ - est_inclZ) > tol_incl) {
    Serial.println("Error en inclinación eje Z");
  }
  // Si todo está correcto
  if ((fabs(ax_ms2 - est_ax) < tol_acc) &&
      (fabs(ay_ms2 - est_ay) < tol_acc) &&
      (fabs(az_ms2 - est_az) < tol_acc) &&
      (fabs(inclX - est_inclX) < tol_incl) &&
      (fabs(inclY - est_inclY) < tol_incl) &&
      (fabs(inclZ - est_inclZ) < tol_incl)) {
    Serial.println("Movimiento CORRECTO ✅");
  } else {
    Serial.println("Movimiento INCORRECTO ❌");
  }
// Variables globales para guardar los valores actuales
float ax_ms2, ay_ms2, az_ms2;
float inclX, inclY, inclZ;


void mediciones() {
  // Leer datos crudos del sensor
  sensor.getAcceleration(&ax, &ay, &az);
  sensor.getRotation(&gx, &gy, &gz);

  // Convertir aceleraciones a m/s² (1 g = 9.81 m/s²)
  float ax_ms2 = (ax / 16384.0) * 9.81;
  float ay_ms2 = (ay / 16384.0) * 9.81;
  float az_ms2 = (az / 16384.0) * 9.81;

  // Calcular inclinaciones en grados usando trigonometría
  float inclX = atan2(ax_ms2, sqrt(ay_ms2*ay_ms2 + az_ms2*az_ms2)) * 180.0 / PI;
  float inclY = atan2(ay_ms2, sqrt(ax_ms2*ax_ms2 + az_ms2*az_ms2)) * 180.0 / PI;
  float inclZ = atan2(az_ms2, sqrt(ax_ms2*ax_ms2 + ay_ms2*ay_ms2)) * 180.0 / PI;

  // Enviar datos: 3 aceleraciones + 3 inclinaciones
  String data = String(ax_ms2) + "," + String(ay_ms2) + "," + String(az_ms2) + "," +
                String(inclX) + "," + String(inclY) + "," + String(inclZ);

  SerialBT.println(data);
  Serial.println(data);

  Serial.print("Aceleración X [m/s²]: "); Serial.println(ax_ms2);
  Serial.print("Aceleración Y [m/s²]: "); Serial.println(ay_ms2);
  Serial.print("Aceleración Z [m/s²]: "); Serial.println(az_ms2);

  Serial.print("Inclinación eje X [°]: "); Serial.println(inclX);
  Serial.print("Inclinación eje Y [°]: "); Serial.println(inclY);
  Serial.print("Inclinación eje Z [°]: "); Serial.println(inclZ);
}

