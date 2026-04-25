import 'package:flutter/material.dart';

import '/listaejercicios.dart'; 
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';



class Videoejercicios extends StatelessWidget {
  const Videoejercicios({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse("https://www.youtube.com/shorts/WrpQYs_n_Pw");
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
    body: const ListaEjercicios(),
        ); 
    
  }
}
