#include "BluetoothSerial.h"

BluetoothSerial SerialBT;

void setup() {
  Serial.begin(115200);

  // Inicializar Bluetooth con un nombre visible
  SerialBT.begin("ESP32_BT_MINIMO");
  Serial.println("Bluetooth listo, conecta tu app Flutter.");
} 

void loop() {
  // Enviar un mensaje fijo
  SerialBT.println("Hola, está bien");

  // Mostrar también en el monitor serie
  Serial.println("Mensaje enviado: Hola, está bien");

  delay(2000); // cada 2 segundos
}
