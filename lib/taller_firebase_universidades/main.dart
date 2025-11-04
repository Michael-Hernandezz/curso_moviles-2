import 'package:flutter/material.dart';
import 'package:curso_moviles/taller_firebase_universidades/routes/app_router.dart';
import 'package:curso_moviles/taller_firebase_universidades/themes/app_theme.dart'; // Importar el tema
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // build es un metodo que se ejecuta cada vez que se necesita redibujar la pantalla
    return MaterialApp.router(
      theme:
          AppTheme.lightTheme, //thema personalizado y permamente en toda la app
      title:
          'Flutter - UCEVA', // Usa el tema personalizado, no se muestra el tema por defecto. esto se visualiza en toda la app
      routerConfig: appRouter, // Usa el router configurado con go_router
    );
  }
}
