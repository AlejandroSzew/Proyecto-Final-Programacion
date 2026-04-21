import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController {
  final FlutterBlue _ble = FlutterBlue.instance;

  // Stream de resultados de escaneo
  Stream<List<ScanResult>> get scanResults => _ble.scanResults;

  // Escanear dispositivos BLE
  Future<void> scanDevices() async {
    final scanGranted = await Permission.bluetoothScan.request().isGranted;
    final connectGranted = await Permission.bluetoothConnect.request().isGranted;
    final locationGranted = await Permission.location.request().isGranted;

    if (scanGranted && connectGranted && locationGranted) {
      _ble.startScan(timeout: const Duration(seconds: 10));
    } else {
      print("❌ Permisos no concedidos");
    }
  }

  // Conectar a un dispositivo
  Future<void> connectToDevice(BluetoothDevice device) async {
    print(device);
    try {
      await device.connect(timeout: const Duration(seconds: 15));
      device.state.listen((state) {
        switch (state) {
          case BluetoothDeviceState.connecting:
            print("🔄 Conectando a: ${device.name}");
            break;
          case BluetoothDeviceState.connected:
            print("✅ Conectado a: ${device.name}");
            break;
          case BluetoothDeviceState.disconnected:
            print("❌ Desconectado de: ${device.name}");
            break;
          default:
            break;
        }
      });
    } catch (e) {
      print("⚠️ Error al conectar: $e");
    }
  }

  // Desconectar
  Future<void> disconnectDevice(BluetoothDevice device) async {
    await device.disconnect();
    print("🔌 Dispositivo desconectado");
  }
}
