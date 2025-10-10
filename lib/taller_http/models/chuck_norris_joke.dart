/// Modelo para representar una broma de Chuck Norris
class ChuckNorrisJoke {
  String id;
  String value; // El texto de la broma
  List<String> categories;
  String iconUrl;
  String url;
  String createdAt;
  String updatedAt;

  // Constructor de la clase ChuckNorrisJoke con los atributos requeridos
  // esto se hace para que al crear una instancia de ChuckNorrisJoke, estos atributos sean obligatorios
  // se usa en el fromJson que es un metodo que convierte un JSON en una instancia de ChuckNorrisJoke
  ChuckNorrisJoke({
    required this.id,
    required this.value,
    required this.categories,
    required this.iconUrl,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  // Getter para mantener compatibilidad con el codigo existente
  String get joke => value;

  // Factory porque es un metodo que retorna una nueva instancia de la clase
  // este metodo se usa para convertir un JSON en una instancia de ChuckNorrisJoke
  factory ChuckNorrisJoke.fromJson(Map<String, dynamic> json) {
    return ChuckNorrisJoke(
      id: json['id'] ?? '',
      value: json['value'] ?? '', // El texto de la broma está en 'value'
      categories: List<String>.from(json['categories'] ?? []),
      iconUrl: json['icon_url'] ?? '',
      url: json['url'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  // Metodo para convertir una instancia de ChuckNorrisJoke a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'categories': categories,
      'icon_url': iconUrl,
      'url': url,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Metodo para obtener la fecha de creacion formateada
  String get formattedCreatedAt {
    try {
      final dateTime = DateTime.parse(createdAt);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return createdAt;
    }
  }

  // Metodo para obtener la fecha de actualizacion formateada
  String get formattedUpdatedAt {
    try {
      final dateTime = DateTime.parse(updatedAt);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return updatedAt;
    }
  }
}
