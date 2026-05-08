#include <WiFi.h>
#include <WebServer.h>

const char* ssid = "ESP32_AP";
const char* password = "12345678";

WebServer server(80);

void setup() {
  Serial.begin(115200);

  // Crear Access Point
  WiFi.softAP(ssid, password);
  Serial.print("AP IP: ");
  Serial.println(WiFi.softAPIP());

  // Endpoint simple
  server.on("/mensaje", []() {
    server.send(200, "text/plain", "Hola desde el servidor ESP32 ");
  });

  server.begin();
}

void loop() {
  server.handleClient();
}
