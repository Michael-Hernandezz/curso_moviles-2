import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/chuck_norris_joke.dart';
import '../services/chuck_norris_service.dart';

class ChuckNorrisListView extends StatefulWidget {
  const ChuckNorrisListView({super.key});

  @override
  State<ChuckNorrisListView> createState() => _ChuckNorrisListViewState();
}

class _ChuckNorrisListViewState extends State<ChuckNorrisListView> {
  // Se crea una instancia de la clase ChuckNorrisService
  final ChuckNorrisService _chuckNorrisService = ChuckNorrisService();
  // Se declara una variable de tipo Future que contendra la lista de bromas
  late Future<List<ChuckNorrisJoke>> _futureJokes;

  @override
  void initState() {
    super.initState();
    // Se llama al metodo getRandomJokes de la clase ChuckNorrisService
    _futureJokes = _chuckNorrisService.getRandomJokes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuck Norris Jokes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _futureJokes = _chuckNorrisService.getRandomJokes();
              });
            },
          ),
        ],
      ),
      // Se crea un FutureBuilder que se encargara de construir la lista de bromas
      // FutureBuilder se utiliza para construir widgets basados en un Future
      body: FutureBuilder<List<ChuckNorrisJoke>>(
        future: _futureJokes,
        builder: (context, snapshot) {
          // snapshot contiene la respuesta del Future
          if (snapshot.hasData) {
            // Se obtiene la lista de bromas
            final jokes = snapshot.data!;
            // ListView.builder se utiliza para construir una lista de elementos de manera eficiente
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, index) {
                  final joke = jokes[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    // GestureDetector se utiliza para detectar gestos del usuario
                    // en este caso se utiliza para navegar a la vista de detalle de la broma
                    child: GestureDetector(
                      onTap: () {
                        context.push('/chuck-norris/${joke.id}');
                      },
                      child: Card(
                        elevation: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            gradient: LinearGradient(
                              colors: [
                                Colors.orange.shade400,
                                Colors.deepOrange.shade600,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Avatar de Chuck Norris
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      joke.iconUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Icon(
                                              Icons.sentiment_very_satisfied,
                                              size: 40,
                                              color: Colors.orange.shade700,
                                            );
                                          },
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.orange.shade700,
                                                strokeWidth: 2,
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Contenido de la broma
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Texto de la broma
                                      Text(
                                        joke.joke,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          height: 1.4,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 12),
                                      // Categorías e indicador
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Categorías
                                          if (joke.categories.isNotEmpty)
                                            Expanded(
                                              child: Wrap(
                                                spacing: 4,
                                                children: joke.categories.take(2).map((
                                                  category,
                                                ) {
                                                  return Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 4,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withValues(
                                                            alpha: 0.2,
                                                          ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      category.toUpperCase(),
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          // Icono indicador
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 16, color: Colors.red.shade600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureJokes = _chuckNorrisService.getRandomJokes();
                      });
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.orange),
                SizedBox(height: 16),
                Text(
                  'Cargando bromas de Chuck Norris...',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
