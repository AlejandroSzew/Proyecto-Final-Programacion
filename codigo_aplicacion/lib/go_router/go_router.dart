import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
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
      builder: (context, state) => const VideoEjercicios(),
    ),
    GoRoute(
      path: '/bluetooth',
      builder: (context, state) => const PantallaBluetooth(),
    ),
  ],
);
