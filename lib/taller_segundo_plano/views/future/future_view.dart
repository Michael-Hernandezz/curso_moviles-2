import 'package:flutter/material.dart';
import '../../widgets/base_view.dart';
import '../../services/async_data_service.dart';

/// Demostración simple de Future y async/await
class FutureView extends StatefulWidget {
  const FutureView({super.key});

  @override
  State<FutureView> createState() => _FutureViewState();
}

class _FutureViewState extends State<FutureView> {
  List<String> _datos = [];
  bool _cargando = false;
  String? _error;

  /// Obtener un dato simple
  Future<void> _obtenerDato() async {
    print('[UI] Iniciando obtención de un dato...');

    setState(() {
      _cargando = true;
      _error = null;
      _datos.clear();
    });

    try {
      print('[UI] Llamando al servicio async...');
      final dato = await AsyncDataService.obtenerDato();

      print('[UI] Dato recibido, actualizando UI: $dato');
      setState(() {
        _datos = [dato];
        _cargando = false;
      });
    } catch (e) {
      print(' [UI] Error capturado, mostrando en UI: $e');
      setState(() {
        _error = e.toString();
        _cargando = false;
      });
    }
  }

  /// Obtener múltiples datos
  Future<void> _obtenerMultiplesDatos() async {
    print('[UI] Iniciando obtención de múltiples datos...');

    setState(() {
      _cargando = true;
      _error = null;
      _datos.clear();
    });

    try {
      print(' [UI] Llamando al servicio para múltiples consultas...');
      final datos = await AsyncDataService.obtenerMultiplesDatos();

      print(' [UI] Múltiples datos recibidos, actualizando UI: $datos');
      setState(() {
        _datos = datos;
        _cargando = false;
      });
    } catch (e) {
      print('[UI] Error en múltiples consultas: $e');
      setState(() {
        _error = e.toString();
        _cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Future y Async/Await',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Botones
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _cargando ? null : _obtenerDato,
                    child: const Text('Obtener Dato'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _cargando ? null : _obtenerMultiplesDatos,
                    child: const Text('Múltiples Datos'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Estado
            if (_cargando) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              const Text('Cargando...'),
            ] else if (_error != null) ...[
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 10),
              Text(
                'Error: $_error',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ] else if (_datos.isNotEmpty) ...[
              const Icon(Icons.check_circle, color: Colors.green, size: 48),
              const SizedBox(height: 10),
              const Text('Datos obtenidos:'),
              const SizedBox(height: 10),
              ...(_datos.map(
                (dato) => Card(child: ListTile(title: Text(dato))),
              )),
            ] else ...[
              const Icon(Icons.info, color: Colors.grey, size: 48),
              const SizedBox(height: 10),
              const Text('Presiona un botón para obtener datos'),
            ],
          ],
        ),
      ),
    );
  }
}
