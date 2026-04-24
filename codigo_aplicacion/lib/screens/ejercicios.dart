import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Ejercicios extends StatelessWidget {
  const Ejercicios({super.key});
  String feedback = 'bien hecho el curl de biceps un poco de inclinación en el eje izquierdo'
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
               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  ),
)

            ],
          ),
        ), 
    );
  }
}
