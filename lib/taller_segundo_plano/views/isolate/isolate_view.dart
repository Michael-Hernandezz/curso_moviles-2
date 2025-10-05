import 'dart:isolate';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../widgets/base_view.dart';

/// Clase para enviar datos al isolate
class IsolateData {
  final SendPort sendPort;
  final String task;
  final int parameter;

  IsolateData(this.sendPort, this.task, this.parameter);
}

/// Función principal del isolate que maneja diferentes tareas
void isolateEntryPoint(IsolateData data) {
  final sendPort = data.sendPort;
  final task = data.task;
  final parameter = data.parameter;

  try {
    switch (task) {
      case 'fibonacci':
        final result = _calcularFibonacci(parameter);
        sendPort.send({
          'status': 'success',
          'result': 'Fibonacci($parameter) = $result',
          'value': result,
        });
        break;

      case 'factorial':
        final result = _calcularFactorial(parameter);
        sendPort.send({
          'status': 'success',
          'result': 'Factorial($parameter) = $result',
          'value': result,
        });
        break;

      case 'primes':
        final result = _contarPrimos(parameter);
        sendPort.send({
          'status': 'success',
          'result': 'Primos hasta $parameter: $result números',
          'value': result,
        });
        break;

      case 'heavy_sum':
        final result = _sumaPesada(parameter);
        sendPort.send({
          'status': 'success',
          'result': 'Suma pesada hasta $parameter = $result',
          'value': result,
        });
        break;

      default:
        sendPort.send({
          'status': 'error',
          'result': 'Tarea no reconocida: $task',
        });
    }
  } catch (e) {
    sendPort.send({'status': 'error', 'result': 'Error: $e'});
  }
}

/// Calcular Fibonacci de forma recursiva (CPU intensivo)
int _calcularFibonacci(int n) {
  if (n <= 1) return n;
  return _calcularFibonacci(n - 1) + _calcularFibonacci(n - 2);
}

/// Calcular factorial
BigInt _calcularFactorial(int n) {
  BigInt result = BigInt.one;
  for (int i = 2; i <= n; i++) {
    result *= BigInt.from(i);
  }
  return result;
}

/// Contar números primos hasta n
int _contarPrimos(int n) {
  int count = 0;
  for (int i = 2; i <= n; i++) {
    if (_esPrimo(i)) count++;
  }
  return count;
}

bool _esPrimo(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= sqrt(n); i++) {
    if (n % i == 0) return false;
  }
  return true;
}

/// Suma pesada con cálculos adicionales
int _sumaPesada(int n) {
  int suma = 0;
  for (int i = 0; i < n; i++) {
    // Agregar algunos cálculos extra para hacerlo más pesado
    suma += i;
    if (i % 1000 == 0) {
      // Simular trabajo extra cada 1000 iteraciones
      sqrt(i.toDouble()).toInt();
    }
  }
  return suma;
}

/// Demostración avanzada de Isolate con múltiples tareas CPU-intensivas
class IsolateView extends StatefulWidget {
  const IsolateView({super.key});

  @override
  State<IsolateView> createState() => _IsolateViewState();
}

class _IsolateViewState extends State<IsolateView> {
  String _resultado = '';
  bool _calculando = false;
  String _tareaActual = '';

  /// Ejecutar tarea en isolate
  Future<void> _ejecutarTarea(String task, int parameter) async {
    print('Iniciando tarea: $task con parámetro: $parameter');

    setState(() {
      _calculando = true;
      _resultado = '';
      _tareaActual = task;
    });

    try {
      final receivePort = ReceivePort();
      final isolateData = IsolateData(receivePort.sendPort, task, parameter);

      print('Spawning isolate para $_tareaActual...');
      await Isolate.spawn(isolateEntryPoint, isolateData);

      receivePort.listen((data) {
        print('Resultado recibido del isolate: $data');

        setState(() {
          if (data['status'] == 'success') {
            _resultado = data['result'];
          } else {
            _resultado = 'Error: ${data['result']}';
          }
          _calculando = false;
        });
        receivePort.close();
      });
    } catch (e) {
      print(' Error ejecutando tarea: $e');
      setState(() {
        _resultado = 'Error: $e';
        _calculando = false;
      });
    }
  }

  Widget _buildTaskButton(
    String title,
    String task,
    int parameter,
    Color color,
    IconData icon,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _calculando ? null : () => _ejecutarTarea(task, parameter),
        icon: Icon(icon),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Isolate - Tareas CPU Intensivas',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Información
            Card(
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Los Isolates ejecutan código CPU-intensivo sin bloquear la UI principal. '
                  'Cada tarea se ejecuta en un hilo separado.',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Botones de tareas
            _buildTaskButton(
              'Fibonacci(35) - Recursivo',
              'fibonacci',
              35,
              Colors.purple,
              Icons.repeat,
            ),

            const SizedBox(height: 12),

            _buildTaskButton(
              'Factorial(100)',
              'factorial',
              100,
              Colors.green,
              Icons.functions,
            ),

            const SizedBox(height: 12),

            _buildTaskButton(
              'Contar Primos hasta 100,000',
              'primes',
              100000,
              Colors.orange,
              Icons.calculate,
            ),

            const SizedBox(height: 12),

            _buildTaskButton(
              'Suma Pesada (50M iteraciones)',
              'heavy_sum',
              50000000,
              Colors.red,
              Icons.add,
            ),

            const SizedBox(height: 30),

            // Estado actual
            if (_calculando) ...[
              Card(
                color: Colors.orange.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10),
                      Text(
                        'Ejecutando: $_tareaActual',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Procesando en segundo plano...\n¡La UI sigue respondiendo!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Resultado
            if (_resultado.isNotEmpty && !_calculando) ...[
              Card(
                color: _resultado.startsWith('Error')
                    ? Colors.red.shade50
                    : Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _resultado.startsWith('Error')
                                ? Icons.error
                                : Icons.check_circle,
                            color: _resultado.startsWith('Error')
                                ? Colors.red
                                : Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _resultado.startsWith('Error')
                                  ? 'Error en cálculo'
                                  : 'Resultado obtenido',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(_resultado, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
