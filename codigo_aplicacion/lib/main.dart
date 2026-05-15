import 'package:flutter/material.dart';
import 'package:codigo_aplicacion/go_router/go_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      
      routerConfig: appRouter,     
        theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF1E2A38),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF1E2A38),
          secondary: const Color(0xFFE53935),
          surface: const Color(0xFF212121),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white),
          bodyLarge: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16,
              color: Colors.white70),
          labelLarge: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.greenAccent),
        ),
      ),    // usa tu GoRouter definido en app_router.dart
      );
  }
}
