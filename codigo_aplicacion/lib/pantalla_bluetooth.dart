import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class PantallaBluetooth extends StatefulWidget {
  const PantallaBluetooth({super.key});

  @override
  State<PantallaBluetooth> createState() => _MyPantallaBluetoothState();
}

class _MyPantallaBluetoothState extends State<PantallaBluetooth> {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  void initState() {
    super.initState();
    // Escuchar cambios de estado
    flutterBlue.state.listen((state) {
      print("Bluetooth state: $state");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pantalla Bluetooth")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ScanResult>>(
              stream: flutterBlue.scanResults,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final result = snapshot.data![index];
                      return ListTile(
                        title: Text(result.device.name.isNotEmpty
                            ? result.device.name
                            : "Dispositivo sin nombre"),
                        subtitle: Text(result.device.id.toString()),
                        trailing: Text("${result.rssi} dBm"),
                        onTap: () async {
                          await result.device.connect();
                          print("Conectado a ${result.device.name}");
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("No se encontró dispositivo"));
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              flutterBlue.startScan(timeout: const Duration(seconds: 5));
            },
            child: const Text("SCAN"),
          ),
        ],
      ),
    );
  }
}
