import 'package:go_router/go_router.dart';
import 'package:codigo_aplicacion/screens/login.dart';
import 'package:codigo_aplicacion/screens/homescreen.dart';
import 'package:codigo_aplicacion/screens/rutinas.dart';
import 'package:codigo_aplicacion/screens/estadisticas.dart';
import 'package:codigo_aplicacion/screens/configuracion.dart';
import 'package:codigo_aplicacion/screens/ejercicios.dart';
import 'package:codigo_aplicacion/screens/videoejercicios.dart';


final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/homescreen',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/rutinas',
      builder: (context, state) => const Rutinas(),
    ),
    GoRoute(
      path: '/estadisticas',
      builder: (context, state) => const Estadisticas(),
    ),
    GoRoute(
      path: '/configuracion',
      builder: (context, state) => const Configuracion(),
    ),
    GoRoute(
      path: '/ejercicios',
      builder: (context, state) => const Ejercicios(),
    ),
    GoRoute(
      path: '/videoejercicios',
      builder: (context, state) => const Videoejercicios(),
    ),


  ],
);
