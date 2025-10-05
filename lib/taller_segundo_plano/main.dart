import 'package:flutter/material.dart';
import 'package:curso_moviles/taller_segundo_plano/routes/app_router.dart';
import 'package:curso_moviles/taller_segundo_plano/themes/app_theme.dart'; // Importar el tema

void main() async {
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
