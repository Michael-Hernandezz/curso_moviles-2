import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Importar todas las vistas
import '../views/home/home_screen.dart';
import '../views/paso_parametros/paso_parametros_screen.dart';
import '../views/paso_parametros/detalle_screen.dart';
import '../views/ciclo_vida/ciclo_vida_screen.dart';
import '../views/future/future_view.dart';
import '../views/isolate/isolate_view.dart';
import '../views/timer/timer_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/paso_parametros',
      name: 'paso_parametros',
      builder: (BuildContext context, GoRouterState state) {
        return const PasoParametrosScreen();
      },
    ),
    GoRoute(
      path: '/detalle/:parametro/:metodo',
      name: 'detalle',
      builder: (BuildContext context, GoRouterState state) {
        final parametro = state.pathParameters['parametro'] ?? 'Sin parámetro';
        final metodo = state.pathParameters['metodo'] ?? 'push';
        return DetalleScreen(parametro: parametro, metodoNavegacion: metodo);
      },
    ),
    GoRoute(
      path: '/ciclo_vida',
      name: 'ciclo_vida',
      builder: (BuildContext context, GoRouterState state) {
        return const CicloVidaScreen();
      },
    ),
    GoRoute(
      path: '/future',
      name: 'future',
      builder: (BuildContext context, GoRouterState state) {
        return const FutureView();
      },
    ),
    GoRoute(
      path: '/isolate',
      name: 'isolate',
      builder: (BuildContext context, GoRouterState state) {
        return const IsolateView();
      },
    ),
    GoRoute(
      path: '/timer',
      name: 'timer',
      builder: (BuildContext context, GoRouterState state) {
        return const TimerView();
      },
    ),
    // Rutas adicionales que están en el drawer pero pueden no tener pantallas aún
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (BuildContext context, GoRouterState state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Configuración')),
          body: const Center(child: Text('Pantalla de Configuración')),
        );
      },
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (BuildContext context, GoRouterState state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Perfil')),
          body: const Center(child: Text('Pantalla de Perfil')),
        );
      },
    ),
    GoRoute(
      path: '/pokemons',
      name: 'pokemons',
      builder: (BuildContext context, GoRouterState state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Pokemons')),
          body: const Center(child: Text('Pantalla de Pokemons')),
        );
      },
    ),
  ],
);
