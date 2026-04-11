

import 'package:codigo_aplicacion/main.dart';
import 'package:codigo_aplicacion/pantalla4.dart';
import 'package:flutter/material.dart';

class Pantalla3 extends StatefulWidget {
  const Pantalla3 ({super.key});

  @override
  State<Pantalla3> createState() => _Pantalla3State();
}

class _Pantalla3State extends State<Pantalla3> {

  void _enviarMensaje(String mensaje) {
    print(mensaje);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("bienvenido a la pantalla 3")
      ),
   
    body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed:() {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Pantalla1()),
            );
              } , child: const Text("volver a inicio")),
              
              ElevatedButton(onPressed: () {
                Navigator.push(
               context,
               MaterialPageRoute(builder: (context) =>   Pantalla4(funcion: _enviarMensaje)),
            );
              } , 
              child: const Text('ir a pantalla 4'))
             
            ],
          ),
        ), 
    );
  }
}
