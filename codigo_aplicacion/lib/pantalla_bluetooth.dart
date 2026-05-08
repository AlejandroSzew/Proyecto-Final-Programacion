import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDemo extends StatefulWidget {
  const BluetoothDemo({super.key});

  @override
  State<BluetoothDemo> createState() => _BluetoothDemoState();
}

class _BluetoothDemoState extends State<BluetoothDemo> {
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
      appBar: AppBar(title: const Text("Demo Bluetooth")),
      body: Center(
        child: Text(
          feedback,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
