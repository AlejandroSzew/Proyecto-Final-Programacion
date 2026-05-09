import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class PantallaBluetooth extends StatefulWidget {
  const PantallaBluetooth({super.key});

  @override
  State<PantallaBluetooth> createState() => _PantallaBluetoothState();
}

class _PantallaBluetoothState extends State<PantallaBluetooth> {
  BluetoothConnection? connection;
  String feedback = "Esperando datos...";

  @override
  void initState() {
    super.initState();
    _connectToESP32();
  }

  Future<void> _connectToESP32() async {
    try {
      // Cambia por la MAC real de tu ESP32
      connection = await BluetoothConnection.toAddress("00:11:22:33:44:55");
      connection!.input!.listen((data) {
        String recibido = String.fromCharCodes(data).trim();
        setState(() {
          feedback = recibido;
        });
      });
    } catch (e) {
      setState(() {
        feedback = "Error al conectar: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pantalla Bluetooth")),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              feedback,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
