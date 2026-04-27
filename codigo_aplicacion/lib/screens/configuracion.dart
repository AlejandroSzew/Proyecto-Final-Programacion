import 'package:codigo_aplicacion/entities/users.dart';
import 'package:codigo_aplicacion/pantalla_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Configuracion extends StatefulWidget {
  const Configuracion ({super.key});

  @override
  State<Configuracion> createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  bool notificaciones = true;
  bool vibracion = false;
  bool alertasLed = true;
  bool modoOscuro = false;

  @override
  Widget build(BuildContext context){
    Users miUsuario = Users(
  name: 'ale',
  password: 'ale',
  email: 'ale@gmail.com',
  age: '20',
);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(75, 51, 0, 255),
        title:  Text("Bienvenido ${miUsuario.name}", style: TextStyle(fontSize: 30),)
      ),
       body: ListView(
        children: [
          const ListTile(
            title: Text("Opciones generales"),
          ),
          SwitchListTile(
            title: const Text("Notificaciones"),
            value: notificaciones,
            onChanged: (val) {
              setState(() => notificaciones = val);
            },
          ),
          SwitchListTile(
            title: const Text("Vibración"),
            value: vibracion,
            onChanged: (val) {
              setState(() => vibracion = val);
            },
          ),
          SwitchListTile(
            title: const Text("Alertas LED"),
            value: alertasLed,
            onChanged: (val) {
              setState(() => alertasLed = val);
            },
          ),
          SwitchListTile(
            title: const Text("Modo oscuro"),
            value: modoOscuro,
            onChanged: (val) {
              setState(() => modoOscuro = val);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.bluetooth),
            title: const Text("Pantalla Bluetooth"),
            onTap: () {
              context.push('/pantallabluetooth');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Acerca de la aplicación"),
            subtitle: const Text("Versión 1.0.0"),
            onTap: () {},
          ),
        ]
    )
    
    );
  }
}