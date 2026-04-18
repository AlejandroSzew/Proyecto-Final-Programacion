import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaEjercicios extends StatelessWidget {
  const ListaEjercicios({super.key});

  // Función para abrir el link del video
  Future<void> _abrirVideo(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lista de ejercicios con su nombre y link (vos ponés los links reales)
    final ejercicios = [
      {
        "nombre": "Curl de bíceps parado",
        "link": "https://www.youtube.com/shorts/WrpQYs_n_Pw"
      },
      {
        "nombre": "Elevaciones laterales",
        "link": "https://www.youtube.com/shorts/rv44DZhCO1g"
      },
      {
        "nombre": "Sentadilla",
        "link": "https://www.youtube.com/shorts/UbIClfnHOuw"
      },
    ];

    return ListView.builder(
      itemCount: ejercicios.length,
      itemBuilder: (context, index) {
        final ejercicio = ejercicios[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.fitness_center),
            title: Text(ejercicio["nombre"]!),
            onTap: () {
              _abrirVideo(ejercicio["link"]!);
            },
          ),
        );
      },
    );
  }
}
