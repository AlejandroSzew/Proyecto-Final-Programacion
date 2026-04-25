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
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: userController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: "Usuario",
                ),
              ),
              TextField(
                controller: passController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: "Contraseña",
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (userController.text.isEmpty || passController.text.isEmpty){
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Por favor completa todos los campos")),
                    );
                  } 
                  else if (userController.text == "ale" &&
                      passController.text == "1234") {
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
                child: const Text("Ingresar"),
              ),
            ],
          ),
        ),
      );
  }
}