import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/chuck_norris_joke.dart';

// El chuck norris service es el encargado de hacer las peticiones a la API de Chuck Norris
class ChuckNorrisService {
  // URL base de la API de Chuck Norris desde el archivo .env
  String get _baseUrl => dotenv.env['CHUCK_NORRIS_API_BASE_URL']!;

  // Metodo para obtener una lista de bromas aleatorias
  Future<List<ChuckNorrisJoke>> getRandomJokes({int count = 10}) async {
    List<ChuckNorrisJoke> jokes = [];

    // Hacemos multiples peticiones para obtener bromas aleatorias
    for (int i = 0; i < count; i++) {
      try {
        final response = await http.get(Uri.parse('$_baseUrl/random'));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          jokes.add(ChuckNorrisJoke.fromJson(data));
        }
      } catch (e) {
        // Si hay error en una broma, continuamos con las siguientes
        // En una app de produccion se usaria un sistema de logging apropiado
        continue;
      }
    }

    if (jokes.isEmpty) {
      throw Exception('No se pudieron obtener bromas de Chuck Norris');
    }

    return jokes;
  }

  // Metodo para obtener bromas por categoria
  Future<List<ChuckNorrisJoke>> getJokesByCategory(
    String category, {
    int count = 10,
  }) async {
    List<ChuckNorrisJoke> jokes = [];

    for (int i = 0; i < count; i++) {
      try {
        final response = await http.get(
          Uri.parse('$_baseUrl/random?category=$category'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          jokes.add(ChuckNorrisJoke.fromJson(data));
        }
      } catch (e) {
        // En una app de produccion se usaria un sistema de logging apropiado
        continue;
      }
    }

    return jokes;
  }

  // Metodo para obtener una broma especifica por ID
  Future<ChuckNorrisJoke> getJokeById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ChuckNorrisJoke.fromJson(data);
    } else {
      throw Exception('Error al obtener la broma con ID: $id');
    }
  }

  // Metodo para obtener todas las categorias disponibles
  Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<String>.from(data);
    } else {
      throw Exception('Error al obtener las categorias');
    }
  }

  // Metodo para buscar bromas por texto
  Future<List<ChuckNorrisJoke>> searchJokes(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?query=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['result'];

      return results
          .map((jokeData) => ChuckNorrisJoke.fromJson(jokeData))
          .toList();
    } else {
      throw Exception('Error al buscar bromas con el termino: $query');
    }
  }
}
