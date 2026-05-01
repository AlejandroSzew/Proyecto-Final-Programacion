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

int msboton = 0;
#define PIN_BOTON 0   // Ajusta al pin real
#define PIN_LED_R 2   // Ajusta al pin real
#define PIN_LED_G 4   // Ajusta al pin real
#define PIN_LED_B 5   // Ajusta al pin real

const char* ssid = "MECA-IoT";
const char* password = "IoT$2026";

AsyncWebServer server(80);

void setup() {
  Serial.begin(57600);
  Wire.begin();
  sensor.initialize();

  // Bluetooth
  SerialBT.begin("ESP32_CLASSIC_BT");
  Serial.println("Bluetooth listo, conecta tu app Flutter.");

  // Pines
  pinMode(PIN_BOTON, INPUT_PULLUP);
  pinMode(PIN_LED_R, OUTPUT);
  pinMode(PIN_LED_G, OUTPUT);
  pinMode(PIN_LED_B, OUTPUT);

  // WiFi AP (para comunicación con otros ESP32)
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
      Serial.println("Inicialización completa.");
      estadoMaq_General = MEDICIONES;
      break;

    case MEDICIONES:
      mediciones();
      medicionesEstandar();
      break;

    case C_WIFI:
      // Ejemplo de endpoint para enviar valores
      server.on("/ax", HTTP_GET, [](AsyncWebServerRequest *request){
        request->send(200, "text/plain", String(ax_ms2));
      });
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
      // Enviar datos por Bluetooth
      {
        String data = String(ax_ms2) + "," + String(ay_ms2) + "," + String(az_ms2) + "," +
                      String(inclX) + "," + String(inclY) + "," + String(inclZ);
        SerialBT.println(data);
      }
      break;

    case RST:
      // Reset del sistema
      break;
  }
}

void mediciones() {
  // Leer datos crudos del sensor
  sensor.getAcceleration(&ax, &ay, &az);
  sensor.getRotation(&gx, &gy, &gz);

  // Convertir aceleraciones a m/s²
  ax_ms2 = (ax / 16384.0) * 9.81;
  ay_ms2 = (ay / 16384.0) * 9.81;
  az_ms2 = (az / 16384.0) * 9.81;

  // Calcular inclinaciones
  inclX = atan2(ax_ms2, sqrt(ay_ms2*ay_ms2 + az_ms2*az_ms2)) * 180.0 / PI;
  inclY = atan2(ay_ms2, sqrt(ax_ms2*ax_ms2 + az_ms2*az_ms2)) * 180.0 / PI;
  inclZ = atan2(az_ms2, sqrt(ax_ms2*ax_ms2 + ay_ms2*ay_ms2)) * 180.0 / PI;

  // Mostrar datos
  Serial.print("Aceleración X [m/s²]: "); Serial.println(ax_ms2);
  Serial.print("Aceleración Y [m/s²]: "); Serial.println(ay_ms2);
  Serial.print("Aceleración Z [m/s²]: "); Serial.println(az_ms2);

  Serial.print("Inclinación eje X [°]: "); Serial.println(inclX);
  Serial.print("Inclinación eje Y [°]: "); Serial.println(inclY);
  Serial.print("Inclinación eje Z [°]: "); Serial.println(inclZ);
}

void medicionesEstandar() {
  // Valores esperados en reposo
  float est_ax = 0.0;
  float est_ay = 9.81;
  float est_az = 0.0;
  float est_inclX = 0.0;
  float est_inclY = 0.0;
  float est_inclZ = 90.0;

  float tol_acc = 2.0;
  float tol_incl = 5.0;

  bool correcto = true;

  if (abs(ax_ms2 - est_ax) > tol_acc) { Serial.println("Error eje X"); correcto = false; }
  if (abs(ay_ms2 - est_ay) > tol_acc) { Serial.println("Error eje Y"); correcto = false; }
  if (abs(az_ms2 - est_az) > tol_acc) { Serial.println("Error eje Z"); correcto = false; }

  if (abs(inclX - est_inclX) > tol_incl) { Serial.println("Error inclinación X"); correcto = false; }
  if (abs(inclY - est_inclY) > tol_incl) { Serial.println("Error inclinación Y"); correcto = false; }
  if (abs(inclZ - est_inclZ) > tol_incl) { Serial.println("Error inclinación Z"); correcto = false; }

  if (correcto) {
    Serial.println("Movimiento CORRECTO ");
    SerialBT.println("Movimiento CORRECTO ");
  } else {
    Serial.println("Movimiento INCORRECTO ");
    SerialBT.println("Movimiento INCORRECTO ");
  }
}
