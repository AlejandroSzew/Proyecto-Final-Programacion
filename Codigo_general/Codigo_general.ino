#include "I2Cdev.h"
#include "MPU6050.h"
#include "Wire.h"
#include "WiFi.h"
#include "ESPAsyncWebServer.h"
#include "BluetoothSerial.h"

MPU6050 sensor;
BluetoothSerial SerialBT;

// --- Máquina de estados ---
typedef enum { RST,
               INICIALIZACION,
               MEDICIONES,
               C_WIFI,
               ANALISIS_REP,
               ANALISIS_SERIE,
               C_APLICACION } estadoMaq_General_t;

estadoMaq_General_t estadoMaq_General = INICIALIZACION;

// --- Variables globales ---
float ax, ay, az;
float gx, gy, gz;
float ax_ms2, ay_ms2, az_ms2;
float inclX, inclY, inclZ;

// Valores estándar (calibración)
float std_ax, std_ay, std_az;
float std_inclX, std_inclY, std_inclZ;
bool estandarCalibrado = false;

#define PIN_BOTON 0
#define PIN_LED_R 2
#define PIN_LED_G 4
#define PIN_LED_B 5

const char* ssid = "MECA-IoT";
const char* password = "IoT$2026";

AsyncWebServer server(80);

void setup() {
  Serial.begin(57600);
  Wire.begin();
  sensor.initialize();

  SerialBT.begin("ESP32_CLASSIC_BT");
  Serial.println("Bluetooth listo, conecta tu app Flutter.");

  pinMode(PIN_BOTON, INPUT_PULLUP);
  pinMode(PIN_LED_R, OUTPUT);
  pinMode(PIN_LED_G, OUTPUT);
  pinMode(PIN_LED_B, OUTPUT);

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
  switch (estadoMaq_General) {
    case INICIALIZACION:
      digitalWrite(PIN_LED_G, HIGH); // LED verde = calibración
      if (digitalRead(PIN_BOTON) == LOW) {
        mediciones();          // tomar una lectura
        calibrarEstandar();    // guardar como estándar
        estandarCalibrado = true;
        estadoMaq_General = MEDICIONES;
      }
      break;

    case MEDICIONES:
      digitalWrite(PIN_LED_G, LOW);
      mediciones();
      if (estandarCalibrado) {
        compararConEstandar();
      }
      break;

    case ANALISIS_REP:
      if (digitalRead(PIN_BOTON) == LOW) {
        Serial.println("Se tocó el botón, terminó la serie.");
        estadoMaq_General = RST;
      }
      break;

    case ANALISIS_SERIE:
      if (digitalRead(PIN_BOTON) == LOW && msboton >= 5000) {
        Serial.println("Botón presionado >5s, apagar sistema.");
      }
      break;

    case C_APLICACION:
      {
        String data = String(ax_ms2) + "," + String(ay_ms2) + "," + String(az_ms2) + "," +
                      String(inclX) + "," + String(inclY) + "," + String(inclZ);
        SerialBT.println(data);
      }
      break;

    case RST:
      estandarCalibrado = false;
      estadoMaq_General = INICIALIZACION;
      break;
  }
}

void mediciones() {
  sensor.getAcceleration(&ax, &ay, &az);
  sensor.getRotation(&gx, &gy, &gz);

  ax_ms2 = (ax / 16384.0) * 9.81;
  ay_ms2 = (ay / 16384.0) * 9.81;
  az_ms2 = (az / 16384.0) * 9.81;

  inclX = atan2(ax_ms2, sqrt(ay_ms2*ay_ms2 + az_ms2*az_ms2)) * 180.0 / PI;
  inclY = atan2(ay_ms2, sqrt(ax_ms2*ax_ms2 + az_ms2*az_ms2)) * 180.0 / PI;
  inclZ = atan2(az_ms2, sqrt(ax_ms2*ax_ms2 + ay_ms2*ay_ms2)) * 180.0 / PI;

  Serial.println("Lectura actual:");
  Serial.println(String(ax_ms2) + "," + String(ay_ms2) + "," + String(az_ms2) + "," +
                 String(inclX) + "," + String(inclY) + "," + String(inclZ));
}

void calibrarEstandar() {
  std_ax = ax_ms2;
  std_ay = ay_ms2;
  std_az = az_ms2;
  std_inclX = inclX;
  std_inclY = inclY;
  std_inclZ = inclZ;
  Serial.println("Valores estándar guardados ✅");
}

void compararConEstandar() {
  float tol_acc = 2.0;
  float tol_incl = 5.0;
  bool correcto = true;

  if (abs(ax_ms2 - std_ax) > tol_acc) { Serial.println("Error eje X"); correcto = false; }
  if (abs(ay_ms2 - std_ay) > tol_acc) { Serial.println("Error eje Y"); correcto = false; }
  if (abs(az_ms2 - std_az) > tol_acc) { Serial.println("Error eje Z"); correcto = false; }

  if (abs(inclX - std_inclX) > tol_incl) { Serial.println("Error inclinación X"); correcto = false; }
  if (abs(inclY - std_inclY) > tol_incl) { Serial.println("Error inclinación Y"); correcto = false; }
  if (abs(inclZ - std_inclZ) > tol_incl) { Serial.println("Error inclinación Z"); correcto = false; }

  if (correcto) {
    Serial.println("Movimiento CORRECTO ✅");
    SerialBT.println("Movimiento CORRECTO ✅");
    digitalWrite(PIN_LED_G, HIGH);
  } else {
    Serial.println("Movimiento INCORRECTO ❌");
    SerialBT.println("Movimiento INCORRECTO ❌");
    digitalWrite(PIN_LED_R, HIGH);
  }
}
