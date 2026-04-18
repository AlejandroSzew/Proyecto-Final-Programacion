import 'package:flutter/material.dart';

class listaestatica extends StatelessWidget {
  const listaestatica ({super.key});

  @override
  Widget build(BuildContext context){
    return ListView(
      children: [
        Text("flutter"),
        Text("hola"),

      ],
    );
  }

}