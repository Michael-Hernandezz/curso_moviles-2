import 'dart:math';

/// Servicio simple para demostrar async/await
class AsyncDataService {
  static const List<String> _datos = [
    'Dato 1',
    'Dato 2',
    'Dato 3',
    'Dato 4',
    'Dato 5',
  ];

  /// Simula una consulta async simple
  static Future<String> obtenerDato() async {
    print('Iniciando consulta de datos..., esa cosa a veces falla');

    print(' [DURANTE] Esperando respuesta del servidor (2-3s)...');
    final tiempoEspera = 2 + Random().nextInt(2); // 2-3 segundos
    await Future.delayed(Duration(seconds: tiempoEspera));

    // 20% probabilidad de error
    if (Random().nextInt(5) == 0) {
      print('[ERROR] Fallo en la conexión al obtener datos');
      throw Exception('Error de conexión');
    }

    final dato = _datos[Random().nextInt(_datos.length)];
    print(' Datos obtenidos exitosamente: $dato');
    return dato;
  }

  /// Simula múltiples consultas
  static Future<List<String>> obtenerMultiplesDatos() async {
    final futures = [obtenerDato(), obtenerDato(), obtenerDato()];

    return await Future.wait(futures);
  }
}
