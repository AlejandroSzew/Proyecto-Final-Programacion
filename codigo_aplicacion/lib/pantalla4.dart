import 'package:flutter/material.dart';

class Pantalla4 extends StatelessWidget {
  const Pantalla4 ({required this. funcion, super.key});

  final Function(String) funcion ;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("bienvenido a la pantalla 4")
      ),
       body: Center(
          child: ElevatedButton(
            onPressed: () {
               funcion('mensaje desde la pantalla 4'); 
            },
            child: const Text('Llamar a la funcion')),
       )
    );
  }

}