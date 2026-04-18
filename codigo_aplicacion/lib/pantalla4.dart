import 'package:codigo_aplicacion/pantalla_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:codigo_aplicacion/listaestatica.dart';

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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {
               funcion('mensaje desde la pantalla 4'); 
              },
            child: const Text('Llamar a la funcion')),
            ]
            ),
            
              
            SizedBox(height: 200,
              child: listaestatica(),
                )
            ,ElevatedButton(onPressed:() {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  PantallaBluetooth()),
            );
              } , child: const Text("pantalla bluetooth")),
            ]
        )
       )
    );
  }

}