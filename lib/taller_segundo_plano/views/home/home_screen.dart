import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taller Asincronía')),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Conceptos de Programación Asíncrona',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(Icons.download, color: Colors.blue),
                title: const Text('Future & Async/Await'),
                subtitle: const Text('Operaciones asíncronas'),
                onTap: () => context.go('/future'),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: ListTile(
                leading: const Icon(Icons.timer, color: Colors.green),
                title: const Text('Timer'),
                subtitle: const Text('Cronómetro simple'),
                onTap: () => context.go('/timer'),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: ListTile(
                leading: const Icon(Icons.settings, color: Colors.orange),
                title: const Text('Isolate'),
                subtitle: const Text('Tareas en segundo plano'),
                onTap: () => context.go('/isolate'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
