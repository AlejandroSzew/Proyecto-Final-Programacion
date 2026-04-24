import 'package:flutter/material.dart';
import 'pantalla2.dart'; 
import 'pantalla3.dart'; 
import 'pantalla4.dart'; 

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Pantalla1(), 
    );
  }
}

class Pantalla1 extends StatefulWidget {
  const Pantalla1({super.key});

  @override
  State<Pantalla1> createState() => _Pantalla1State();
}

class _Pantalla1State extends State<Pantalla1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(75, 51, 0, 255),
        title: const Text("Bienvenido a Techeck"),
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
                  )
               
        ,body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
              child: ListTile(
                title: const Text("NOMBRE, EDAD"),
                subtitle: const Text("Peso: "),
              ),
            ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Pantalla2()),
                );
              },
              child: const Text("Nueva Rutina",style: TextStyle(color: Color.fromARGB(20, 0, 255, 0), fontSize:  22),),
            
            ),
          ),
        ],
      )

 );
}
}