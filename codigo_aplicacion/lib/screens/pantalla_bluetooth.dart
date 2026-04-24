import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import '../ble_controller.dart';

class PantallaBluetooth extends StatelessWidget {
  const PantallaBluetooth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BLE Scanner")),
      body: GetBuilder<BleController>(
        init: BleController(),
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResults,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final result = snapshot.data![index];
                          return Card(
                            child: ListTile(
                              title: Text(result.device.name.isNotEmpty
                                  ? result.device.name
                                  : "Dispositivo sin nombre"),
                              subtitle: Text(result.device.id.id),
                              trailing: Text("RSSI: ${result.rssi}"),
                              onTap: () => controller.connectToDevice(result.device),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text("No se encontraron dispositivos"));
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => controller.scanDevices(),
                child: const Text("🔍 Escanear"),
              ),
            ],
          );
        },
      ),
    );
  }
}
