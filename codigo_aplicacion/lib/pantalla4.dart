import 'package:codigo_aplicacion/pantalla_bluetooth.dart';
import 'package:flutter/material.dart';


class Pantalla4 extends StatefulWidget {
  const Pantalla4 ({super.key});

  @override
  State<Pantalla4> createState() => _Pantalla4State();
}

class _Pantalla4State extends State<Pantalla4> {
  bool notificaciones = true;
  bool vibracion = false;
  bool alertasLed = true;
  bool modoOscuro = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("configuracion")
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PantallaBluetooth()),
              );
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