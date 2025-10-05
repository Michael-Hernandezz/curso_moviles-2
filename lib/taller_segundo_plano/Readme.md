# Taller de Asincronía en Flutter

Demostración completa de programación asíncrona en Flutter con **Future/async/await**, **Timer** e **Isolate**.

## 📋 Conceptos Demostrados

### 1. 🔄 Future / Async / Await
- **Qué es**: Representa un valor que estará disponible en el futuro
- **Cuándo usar**: Para operaciones asíncronas como llamadas a API, lectura de archivos, etc.
- **Implementación**: 
  - Servicio simulado con `Future.delayed(2-3s)`
  - Manejo de estados: Cargando → Éxito → Error
  - Logs detallados en consola mostrando el flujo de ejecución

### 2. ⏱️ Timer
- **Qué es**: Temporizador que ejecuta código en intervalos regulares
- **Cuándo usar**: Para cronómetros, animaciones, actualizaciones periódicas
- **Implementación**:
  - Cronómetro ascendente
  - Cuenta regresiva configurable (1, 2, 3, 5, 10 minutos)
  - Controles: Iniciar / Pausar / Reanudar / Reiniciar
  - Limpieza automática de recursos con `dispose()`

### 3. 🔧 Isolate
- **Qué es**: Hilo de ejecución separado para tareas CPU-intensivas
- **Cuándo usar**: Para cálculos pesados que no deben bloquear la UI
- **Implementación**:
  - Fibonacci recursivo (CPU intensivo)
  - Cálculo de factorial
  - Conteo de números primos
  - Suma pesada con millones de iteraciones
  - Comunicación bidireccional con mensajes

## 📁 Estructura del Proyecto

```
lib/taller_segundo_plano/
├── main.dart                    # Punto de entrada con MaterialApp
├── app_router.dart             # Configuración de rutas con go_router
├── services/
│   └── async_data_service.dart # Servicio simulado para Future/async
├── views/
│   ├── home/home_screen.dart   # Pantalla principal con navegación
│   ├── future/future_view.dart # Demostración de Future/async/await
│   ├── timer/timer_view.dart   # Cronómetro y cuenta regresiva
│   └── isolate/isolate_view.dart # Tareas CPU-intensivas
├── widgets/
│   ├── base_view.dart          # Widget base con AppBar y estructura
│   └── custom_drawer.dart      # Menú lateral de navegación
└── theme/
    └── app_theme.dart          # Tema visual de la aplicación
```

## 🖥️ Pantallas y Flujos

### Pantalla Principal (HomeScreen)
- Lista de conceptos con navegación
- Descripción breve de cada funcionalidad

### Future View - Flujo de Asincronía
```
1. Usuario presiona botón
   ↓
2. UI muestra "Cargando..."
   ↓  
3. Servicio simula demora (2-3s)
   ↓
4. UI actualiza con resultado o error
```

**Estados visuales**:
- 🔄 Cargando: Spinner + mensaje
- ✅ Éxito: Lista de datos obtenidos  
- ❌ Error: Mensaje de error en rojo


### Timer View - Flujo del Cronómetro
```
1. Usuario selecciona modo (cronómetro/cuenta regresiva)
   ↓
2. Si es cuenta regresiva: configura tiempo (1-10min)
   ↓
3. Presiona Iniciar → Timer.periodic() cada 1s
   ↓
4. Puede Pausar → timer.cancel()
   ↓
5. Puede Reanudar → nuevo Timer.periodic()
   ↓
6. Reiniciar → resetea valores
```

**Características**:
- Cambio dinámico entre cronómetro/cuenta regresiva
- Formato MM:SS con fuente monospace
- Colores dinámicos (rojo en últimos 10s de cuenta regresiva)
- Alerta cuando cuenta regresiva llega a 0

### Isolate View - Flujo de Tarea Pesada
```
1. Usuario selecciona tarea CPU-intensiva
   ↓
2. UI muestra "Calculando..." pero sigue responsiva
   ↓
3. Isolate.spawn() ejecuta en hilo separado
   ↓
4. Isolate envía resultado via SendPort
   ↓
5. UI recibe mensaje y actualiza pantalla
```

**Tareas disponibles**:
- **Fibonacci(35)**: Recursión intensiva
- **Factorial(100)**: Cálculo con BigInt
- **Primos hasta 100,000**: Algoritmo de búsqueda
- **Suma pesada**: 50M iteraciones con trabajo extra

## 🔧 Detalles Técnicos

### Future/Async Implementation
```dart
static Future<String> obtenerDato() async {
  print(' [ANTES] Iniciando consulta...');
  
  await Future.delayed(Duration(seconds: 2 + Random().nextInt(2)));
  
  if (Random().nextInt(5) == 0) {
    throw Exception('Error de conexión');
  }
  
  return dato;
}
```

### Timer Implementation
```dart
_timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  setState(() {
    if (_esCuentaRegresiva) {
      _segundos--;
      if (_segundos <= 0) {
        _pausarTimer();
        _mostrarAlerta();
      }
    } else {
      _segundos++;
    }
  });
});
```

### Isolate Implementation
```dart
// Entry point del isolate
void isolateEntryPoint(IsolateData data) {
  final result = _calcularFibonacci(data.parameter);
  data.sendPort.send({'status': 'success', 'result': result});
}

// En el widget
await Isolate.spawn(isolateEntryPoint, isolateData);
receivePort.listen((data) {
  setState(() => _resultado = data['result']);
});
```


### Buenas Prácticas

1. **Siempre usar `dispose()`** para limpiar Timers
2. **Manejar errores** en operaciones async
3. **Mostrar indicadores de carga** para mejor UX
4. **Usar Isolates** solo cuando sea necesario (tienen overhead)
5. **Logear el flujo** para debugging y aprendizaje

