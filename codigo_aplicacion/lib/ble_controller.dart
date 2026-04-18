import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController{
  FlutterBlue ble = FlutterBlue.instance;

 Future scanDevices() async{
    if(await Permission.bluetoothScan.request().isGranted){
      if(await Permission.bluetoothConnect.request().isGranted){
        ble.startScan(timeout: Duration(seconds: 10));

        //ble.stopScan();
      }
    }
  }
  Stream<List<ScanResult>> ? get scansResults => ble.scanResults;
}
