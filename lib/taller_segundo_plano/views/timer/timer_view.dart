import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/base_view.dart';

/// Demostración completa de Timer con cronómetro y cuenta regresiva
class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  Timer? _timer;
  int _segundos = 0;
  bool _corriendo = false;
  bool _esCuentaRegresiva = false;
  int _tiempoInicial = 60; // 1 minuto por defecto

  void _iniciarTimer() {
    print(
      '🔄 Iniciando ${_esCuentaRegresiva ? 'cuenta regresiva' : 'cronómetro'}...',
    );

    setState(() {
      _corriendo = true;
      if (_esCuentaRegresiva && _segundos == 0) {
        _segundos = _tiempoInicial;
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_esCuentaRegresiva) {
          _segundos--;
          if (_segundos <= 0) {
            _pausarTimer();
            print('⏰ ¡Tiempo terminado!');
            _mostrarAlerta();
          }
        } else {
          _segundos++;
        }
      });
    });
  }

  void _pausarTimer() {
    print('⏸️ Timer pausado');
    _timer?.cancel();
    setState(() {
      _corriendo = false;
    });
  }

  void _reanudarTimer() {
    print('▶️ Timer reanudado');
    _iniciarTimer();
  }

  void _reiniciarTimer() {
    print('🔄 Timer reiniciado');
    _timer?.cancel();
    setState(() {
      _segundos = _esCuentaRegresiva ? _tiempoInicial : 0;
      _corriendo = false;
    });
  }

  void _cambiarModo() {
    _timer?.cancel();
    setState(() {
      _esCuentaRegresiva = !_esCuentaRegresiva;
      _segundos = _esCuentaRegresiva ? _tiempoInicial : 0;
      _corriendo = false;
    });
    print(
      '🔄 Cambiado a ${_esCuentaRegresiva ? 'cuenta regresiva' : 'cronómetro'}',
    );
  }

  void _configurarTiempo(int minutos) {
    setState(() {
      _tiempoInicial = minutos * 60;
      if (_esCuentaRegresiva) {
        _segundos = _tiempoInicial;
      }
    });
  }

  void _mostrarAlerta() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⏰ ¡Tiempo terminado!'),
        content: const Text('La cuenta regresiva ha llegado a 0'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String _formatearTiempo(int segundos) {
    final minutos = segundos ~/ 60;
    final segs = segundos % 60;
    return '${minutos.toString().padLeft(2, '0')}:${segs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Timer',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Selector de modo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Modo: '),
                    Switch(
                      value: _esCuentaRegresiva,
                      onChanged: (value) => _cambiarModo(),
                    ),
                    Text(
                      _esCuentaRegresiva ? 'Cuenta Regresiva' : 'Cronómetro',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Configuración de tiempo para cuenta regresiva
            if (_esCuentaRegresiva) ...[
              const Text('Configurar tiempo:'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: [1, 2, 3, 5, 10]
                    .map(
                      (minutos) => ElevatedButton(
                        onPressed: () => _configurarTiempo(minutos),
                        child: Text('${minutos}m'),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
            ],

            // Display del tiempo
            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  _formatearTiempo(_segundos),
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                    color: _esCuentaRegresiva
                        ? (_segundos <= 10 ? Colors.red : Colors.orange)
                        : Colors.blue,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Botones de control
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _corriendo ? null : _iniciarTimer,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Iniciar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _corriendo ? _pausarTimer : null,
                  icon: const Icon(Icons.pause),
                  label: const Text('Pausar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
                if (!_corriendo &&
                    _segundos > 0 &&
                    _segundos != (_esCuentaRegresiva ? _tiempoInicial : 0))
                  ElevatedButton.icon(
                    onPressed: _reanudarTimer,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Reanudar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ElevatedButton.icon(
                  onPressed: _reiniciarTimer,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reiniciar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Estado actual
            Card(
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  _corriendo
                      ? ' Timer en ejecución'
                      : _segundos == 0
                      ? ' Timer detenido'
                      : ' Timer pausado',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
