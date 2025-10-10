import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'themes/app_theme.dart';
import 'views/chuck_norris_list_view.dart';
import 'views/chuck_norris_detail_view.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ChuckNorrisApp());
}

class ChuckNorrisApp extends StatelessWidget {
  const ChuckNorrisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Chuck Norris Jokes',
      debugShowCheckedModeBanner: false,
      theme: ChuckNorrisTheme.lightTheme,
      darkTheme: ChuckNorrisTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: _router,
    );
  }
}

// Configuración de rutas con GoRouter
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    // Ruta principal - Lista de bromas
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const ChuckNorrisListView(),
    ),

    // Ruta de detalle - Mostrar broma específica
    GoRoute(
      path: '/chuck-norris/:id',
      name: 'joke-detail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ChuckNorrisDetailView(id: id);
      },
    ),
  ],

  // Manejo de errores de navegación
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(
      title: const Text('Error'),
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(
            'Página no encontrada',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'La ruta "${state.uri}" no existe',
            style: TextStyle(fontSize: 16, color: Colors.red.shade400),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Ir al inicio'),
          ),
        ],
      ),
    ),
  ),
);

// Widget de presentación opcional (para mostrar información de la app)
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade400, Colors.deepOrange.shade700],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono principal
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.sentiment_very_satisfied,
                    size: 80,
                    color: Colors.orange.shade700,
                  ),
                ),
                const SizedBox(height: 32),

                // Título
                const Text(
                  'Chuck Norris\nJokes',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Subtítulo
                const Text(
                  'Las mejores bromas del hombre\nmás poderoso del mundo',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Botón de entrada
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.orange.shade700,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                  ),
                  child: const Text(
                    'Ver Bromas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
