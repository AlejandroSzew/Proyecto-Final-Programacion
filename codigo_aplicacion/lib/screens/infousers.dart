import 'package:codigo_aplicacion/entities/users.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Infousers extends StatefulWidget {
  const Infousers({super.key});

  @override
  State<Infousers> createState() => _InfousersState();
}

class _InfousersState extends State<Infousers> {
  String title = "Bienvenido a Techeck";
  final TextEditingController ageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  Users miUsuario = Users(
  name: 'ale',
  password: 'ale',
  email: 'ale@gmail.com',
  age: '20',
);

    return Scaffold(
        appBar: AppBar(title: Text(title)),
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
               
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: "Edad",
                ),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                ),
              
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (ageController.text.isEmpty || nameController.text.isEmpty){
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Por favor completa todos los campos")),
                    );
                  } 
                  else {
                  // Actualizar el objeto con lo que escribió el usuario
                  setState(() {
                    miUsuario.name = nameController.text;
                    miUsuario.age = ageController.text;
                  });

                  // Mostrar mensaje
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Tu nombre es ${miUsuario.name}, edad: ${miUsuario.age}")),
                  );
                }
                },
                child: const Text("Ingresar"),
              ),
            ],
          ),
        ),
      );
  }
}