# Chuck Norris Jokes App

Una aplicacion Flutter que consume la API de Chuck Norris para mostrar bromas divertidas del famoso actor y artista marcial.

## Descripcion

Esta aplicacion permite a los usuarios:
- Ver una lista de bromas aleatorias de Chuck Norris
- Navegar a una vista detallada de cada broma
- Copiar y compartir las bromas favoritas
- Disfrutar de una interfaz moderna con temas personalizados

## API Utilizada

**Endpoint Principal:** `https://api.chucknorris.io/jokes`

### Endpoints utilizados:
- `GET /jokes/random` - Obtiene una broma aleatoria
- `GET /jokes/{id}` - Obtiene una broma especifica por ID
- `GET /jokes/categories` - Lista todas las categorias disponibles
- `GET /jokes/search?query={text}` - Busca bromas por texto

### Ejemplo de respuesta JSON:
```json
{
    "categories": [],
    "created_at": "2020-01-05 13:42:24.142371",
    "icon_url": "https://api.chucknorris.io/img/avatar/chuck-norris.png",
    "id": "SR9ceDDCQX2Wc5uEHtYGPA",
    "updated_at": "2020-01-05 13:42:24.142371",
    "url": "https://api.chucknorris.io/jokes/SR9ceDDCQX2Wc5uEHtYGPA",
    "value": "Chuck Norris jumped out of the fire into a bigger fire, Chuck Norris doesn't need a frying pan"
}
```

## Arquitectura del Proyecto

```
lib/taller_http/
├── main.dart                          # Punto de entrada de la aplicacion
├── models/
│   └── chuck_norris_joke.dart         # Modelo para las bromas
├── services/
│   └── chuck_norris_service.dart      # Logica HTTP y comunicacion con API
├── views/
│   ├── chuck_norris_list_view.dart    # Vista principal con lista de bromas
│   └── chuck_norris_detail_view.dart  # Vista de detalle de broma individual
├── themes/
└── app_theme.dart                 # Temas y estilos personalizados
```


#### models/
- **ChuckNorrisJoke**: Modelo que representa una broma con todos sus campos (id, value, categories, iconUrl, url, createdAt, updatedAt)

#### services/
- **ChuckNorrisService**: Maneja todas las peticiones HTTP a la API de Chuck Norris
  - `getRandomJokes()` - Obtiene multiples bromas aleatorias
  - `getJokeById()` - Obtiene una broma especifica
  - `getCategories()` - Lista categorias disponibles
  - `searchJokes()` - Busca bromas por texto

#### views/
- **ChuckNorrisListView**: Lista principal con FutureBuilder, ListView.builder y estados de carga
- **ChuckNorrisDetailView**: Vista detallada con funciones de copia y compartir

#### themes/
- **ChuckNorrisTheme**: Temas personalizados con paleta de colores naranja/dorado

## Rutas con GoRouter

La aplicacion utiliza **go_router** para la navegacion con las siguientes rutas:

### Rutas definidas:

| Ruta | Nombre | Descripcion | Parametros |
|------|---------|-------------|------------|
| `/` | `home` | Lista principal de bromas | Ninguno |
| `/chuck-norris/:id` | `joke-detail` | Detalle de broma especifica | `id` (String) - ID de la broma |

### Ejemplo de navegacion:
```dart
// Navegar a detalle desde lista
context.push('/chuck-norris/${joke.id}');

// Regresar al inicio
context.go('/');
```

### Manejo de errores:
- Ruta no encontrada -> Pantalla de error personalizada
- Parametros invalidos -> Redireccion al inicio

## Caracteristicas Implementadas

### Estados de la Aplicacion
- **Cargando**: CircularProgressIndicator con mensaje personalizado
- **Exito**: Renderizacion de lista o detalle
- **Error**: Pantallas de error amigables con opciones de recuperacion

### Interfaz de Usuario
- **Imagenes**: Avatar de Chuck Norris en cada broma (con fallback a icono)
- **Temas**: Gradientes naranja/dorado inspirados en Chuck Norris
- **Responsive**: Adaptable a diferentes tamanos de pantalla
- **Pull-to-refresh**: Actualizacion manual de contenido

### Funcionalidades
- **Navegacion fluida**: Transiciones suaves entre pantallas
- **Carga optimizada**: Manejo eficiente de multiples peticiones HTTP

## Manejo de Errores y Validaciones

### Validaciones implementadas:
- **StatusCode HTTP**: Verificacion de respuestas exitosas (200)
- **Try/Catch**: Manejo de excepciones en peticiones de red
- **Estados UI**: Feedback visual para todos los estados
- **Campos opcionales**: Validacion de datos nulos/vacios
- **Timeouts**: Manejo de conexiones lentas
- **Fallbacks**: Iconos por defecto cuando fallan las imagenes

### Mensajes al usuario:
- "Cargando bromas de Chuck Norris..."
- "Error al cargar las bromas"
- "Broma copiada al portapapeles"
- "Broma lista para compartir"

## Buenas Practicas Implementadas

### Arquitectura
- **Separacion de responsabilidades**: Modelos, servicios y vistas separados
- **Single Responsibility**: Cada clase tiene una funcion especifica
- **Dependency Injection**: Servicios inyectados en las vistas

### Rendimiento
- **No peticiones en build()**: Uso correcto de `initState()`
- **Future/async/await**: Programacion asincrona apropiada
- **FutureBuilder**: Manejo eficiente de estados asincronos
- **ListView.builder**: Renderizacion eficiente de listas grandes

### UX/UI
- **Estados claros**: Feedback visual para todas las acciones
- **Navegacion intuitiva**: Boton back y navegacion coherente
- **Mensajes amigables**: Comunicacion clara con el usuario
- **Responsive design**: Adaptacion a diferentes pantallas

## Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  go_router: ^13.0.0      # Navegacion declarativa
  http: ^1.1.0            # Peticiones HTTP
  flutter_dotenv: ^5.1.0  # Variables de entorno
```

## Instalacion y Ejecucion

1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd curso_moviles
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicacion**
   ```bash
   # Para la aplicacion completa del curso
   flutter run
   
   # Para ejecutar solo el taller de Chuck Norris
   flutter run --target lib/taller_http/main.dart
   ```

## Capturas de Pantalla

### Lista Principal
- Vista de lista con avatares de Chuck Norris
- Gradientes naranja con tarjetas elevadas
- Estados de carga con indicadores circulares
- Boton de refresh en la AppBar

### Vista de Detalle
- Broma completa con avatar grande
- Informacion de categorias y fechas
- Botones de copiar y compartir
- Navegacion fluida de regreso

### Estados de Error
- Pantallas amigables con iconos descriptivos
- Mensajes claros y opciones de recuperacion
- Botones para regresar al inicio

## Desarrollado por

- Michael Andres Hernandez Lopez... y la tia claudia.

**Taller HTTP - Curso de Desarrollo Movil**  
Implementacion de consumo de APIs REST con Flutter

---

**"Chuck Norris doesn't need HTTP status codes. APIs just work when he's around."**