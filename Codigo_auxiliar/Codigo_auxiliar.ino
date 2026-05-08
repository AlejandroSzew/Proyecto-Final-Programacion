#include "I2Cdev.h"
#include "MPU6050.h"
#include "Wire.h"
#include <WiFi.h>

#include <WebServer.h>
typedef enum { RST,
               INICIALIZACION,
               MEDICIONES,
               C_WIFI,
} estadoMaq_Auxiliar_t;
estadoMaq_Auxiliar_t estadoMaq_Auxiliar = INICIALIZACION;
void medicionesEstandar();
void mediciones();

float ax, ay, az;
float gx, gy, gz;


const char* ssid = "ESP32_C3_Server";
const char* password = "GRUPO3";
WebServer server(80);

void setup() {
  Serial.begin(57600);
  Wire.begin();
  sensor.initialize();

  if (sensor.testConnection()) {
    Serial.println("Sensor iniciado correctamente");
  } else {
    Serial.println("Error al iniciar el sensor");
  }

  // el auxiliar se conecta al AP del principal
  WiFi.begin(ssid, password);
  Serial.println("Conectando al AP principal...");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nConectado al AP principal");
  Serial.print("IP auxiliar: ");
  Serial.println(WiFi.localIP());

  //  definir endpoints
  server.on("/Ax", []() { server.send(200, "text/plain", String(ax)); });
  server.on("/Ay", []() { server.send(200, "text/plain", String(ay)); });
  server.on("/Az", []() { server.send(200, "text/plain", String(az)); });
  server.on("/Gx", []() { server.send(200, "text/plain", String(gx)); });
  server.on("/Gy", []() { server.send(200, "text/plain", String(gy)); });
  server.on("/Gz", []() { server.send(200, "text/plain", String(gz)); });
  definirEndpoints();
server.begin();

}


void loop() {
  Maq_Auxiliar();
}

void Maq_Auxiliar() {
  switch (estadoMaq_Auxiliar) {
    case INICIALIZACION:
      // Podés usar este estado para inicializar LEDs o mensajes
      estadoMaq_Auxiliar = MEDICIONES;
      break;

    case MEDICIONES:
      if (WiFi.status() == WL_CONNECTED) {
        Serial.println("Auxiliar conectado a WiFi, midiendo...");
        mediciones();          // actualizar valores del sensor
        server.handleClient(); // atender peticiones HTTP
      }
      break;

    case C_WIFI:
      // En este estado solo se atienden las peticiones
      server.handleClient();
      break;

    case RST:
      // Reinicio simple
      estadoMaq_Auxiliar = INICIALIZACION;
      break;
  }
}


void mediciones() {
  sensor.getAcceleration(&ax, &ay, &az);
  sensor.getRotation(&gx, &gy, &gz);

  float valores_ax = (ax / 16384.0) * 9.81;
  float valores_ay = (ay / 16384.0) * 9.81;
  float valores_az = (az / 16384.0) * 9.81;

  float valores_gx = gx;
  float valores_gy = gy;
  float valores_gz = gz;

  Serial.print("Ax: "); Serial.print(valores_ax);
  Serial.print(" Ay: "); Serial.print(valores_ay);
  Serial.print(" Az: "); Serial.print(valores_az);
  Serial.print(" Gx: "); Serial.print(valores_gx);
  Serial.print(" Gy: "); Serial.print(valores_gy);
  Serial.print(" Gz: "); Serial.println(valores_gz);
}
void definirEndpoints() {
  server.on("/Ax", []() { server.send(200, "text/plain", String(ax)); });
  server.on("/Ay", []() { server.send(200, "text/plain", String(ay)); });
  server.on("/Az", []() { server.send(200, "text/plain", String(az)); });
  server.on("/Gx", []() { server.send(200, "text/plain", String(gx)); });
  server.on("/Gy", []() { server.send(200, "text/plain", String(gy)); });
  server.on("/Gz", []() { server.send(200, "text/plain", String(gz)); });
}
