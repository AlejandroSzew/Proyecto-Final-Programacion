import 'package:flutter/material.dart';
import 'pantalla2.dart'; 
import 'pantalla3.dart'; 
import 'pantalla4.dart'; 
import 'main.dart'; 
import 'pantalla6.dart';

class Pantalla5 extends StatelessWidget {
  const Pantalla5({super.key});

  @override
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pantalla1()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text("Rutinas"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pantalla2()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Estadísticas"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pantalla3()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Configuración"),
              onTap: () {
                Navigator.push(
                  context,
                 MaterialPageRoute(builder: (context) =>  Pantalla4()),
                 );
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
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Pantalla6()),
            );
              }, child: const Text("Nuevo ejericio")),
              
            ],
          ),
        ), 
    );
  }
}
