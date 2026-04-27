import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Ejercicios extends StatefulWidget {
  const Ejercicios({super.key});

  @override
  State<Ejercicios> createState() => _EjerciciosState();
}

class _EjerciciosState extends State<Ejercicios> {
BluetoothConnection? connection;
String feedback = "Esperando datos...";

@override
void initState() {
  super.initState();
  _connectToESP32();
}

Future<void> _connectToESP32() async {
  try {
    connection = await BluetoothConnection.toAddress("00:11:22:33:44:55"); // ⚠️ cambia por la MAC de tu ESP32
    connection!.input!.listen((data) {
      String recibido = String.fromCharCodes(data).trim();
      setState(() {
        feedback = recibido; // mostrar directamente lo recibido
      });
    });
  } catch (e) {
    setState(() {
      feedback = "Error al conectar: $e";
    });
  }
}
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ejercicios")
      ),
   drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(5),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Menú de navegación",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Inicio"),
              onTap: () {
                context.push('/homescreen');
              },
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text("Rutinas"),
              onTap: () {
                context.push('/rutinas');
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Estadísticas"),
              onTap: () {
                context.push('/estadisticas');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Configuración"),
              onTap: () {
                context.push('/configuracion');
                  }
                  )
                  ]
                  )
                  ),
    body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
              onPressed: () {
              context.push('/videoejercicios');
              },
              child: const Text("Nuevo ejercicio, tutorial"),
              ),
              Card(
              child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
              feedback,
               style: const TextStyle(fontSize: 18),
    ),
  ),
)

            ],
          ),
        ), 
    );
  }
}
