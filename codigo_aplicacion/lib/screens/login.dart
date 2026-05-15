import 'package:codigo_aplicacion/entities/users.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String title = "Bienvenido a Techeck";
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

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
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: userController,
                decoration:  InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: "Usuario",
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              TextField(
                controller: passController,
                decoration:  InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: "Contraseña",
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
                onPressed: () {
                  if (userController.text.isEmpty || passController.text.isEmpty){
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Por favor completa todos los campos")),
                    );
                  } 
                  else if (userController.text == miUsuario.email &&
                      passController.text == miUsuario.password) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login correcto")),
                     
                    );
                    context.go ('/homescreen');
                    setState(() {
                      title = "Bienvenido";
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login incorrecto")),
                    );
                  }
                },
                child:  Text(
                "Ingresar",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              ),
            ],
          ),
        ),
      );
  }
}