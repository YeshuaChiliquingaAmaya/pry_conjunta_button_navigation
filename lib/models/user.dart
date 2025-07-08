// --- lib/models/user.dart ---
// Importaciones necesarias para el modelo
// No necesita dart:convert aquí, ya que la lógica de parseo estará en el servicio
class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
  });

  // Constructor de fábrica para crear un objeto User desde un mapa JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
  }
}