import 'package:codigo_aplicacion/pantalla3.dart';
import 'package:flutter/material.dart';

class Pantalla2 extends StatelessWidget {
  const Pantalla2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("bienvenido a la pantalla 2")
      ),
   
    body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(
                onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Pantalla3()),
            );
              }, child: const Text("Ir a pantalla 3")),

              ElevatedButton(
                onPressed:() {
                Navigator.pop(context);
              } , child: const Text("volver a inicio")
              ),
              
            ],
          ),
        ), 
    );
  }
}
