import 'package:codigo_aplicacion/entities/users.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(), 
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
   Users miUsuario = Users(
  name: 'ale',
  password: 'ale',
  email: 'ale@gmail.com',
  age: '20',
);
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
               
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
              child: ListTile(
                title:  Text("Nombre: ${miUsuario.name},   Edad: ${miUsuario.age}"),
                subtitle: const Text("Peso: "),
              ),
            ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                context.push('/rutinas');
              },
              child: const Text("Nueva Rutina",style: TextStyle(color: Color.fromARGB(20, 0, 255, 0), fontSize:  22),),
            
            ),
            
          ),
          ElevatedButton(
              onPressed: () {
             context.push('/infousers', extra: miUsuario);
            },child: Text("Por favor complete su peso y valores aqui ")),
        ],
      )

 );
}
}