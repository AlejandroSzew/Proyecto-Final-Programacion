import 'package:flutter/material.dart';
import 'pantalla2.dart'; // ajusta la ruta según la ubicación real del archivo

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Pantalla1(), 
    );
  }
}

class Pantalla1 extends StatelessWidget {
  const Pantalla1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(75, 51, 0, 255),
        title: const Text("Bienvenido"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Pantalla2()),
            );
          },
          child: const Text("Ir a pantalla 2"),
        ),
      ),
    );
  }
}
