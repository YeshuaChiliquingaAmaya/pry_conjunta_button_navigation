// --- lib/services/api_service.dart ---
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pry_conjunta_button_navigation/models/user.dart'; // Importa el modelo User

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  // Método estático para obtener la lista de usuarios
  static Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$_baseUrl/users'));

    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa (código 200 OK), parsear el JSON
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      // Si la solicitud no fue exitosa, lanzar una excepción
      throw Exception('Fallo al cargar los usuarios de la API: ${response.statusCode}');
    }
  }
}

// --- lib/viewmodels/age_calculator_viewmodel.dart ---
// No necesita importaciones de Flutter UI aquí
class AgeCalculatorViewModel {
  // Método para calcular la edad
  String calculateAge(DateTime? selectedDate) {
    if (selectedDate == null) {
      return "Por favor, selecciona una fecha.";
    }

    final DateTime today = DateTime.now();
    int years = today.year - selectedDate.year;
    int months = today.month - selectedDate.month;
    int days = today.day - selectedDate.day;

    // Ajustar si el día o el mes actual son anteriores al de nacimiento
    if (days < 0) {
      months--;
      days += DateTime(selectedDate.year, selectedDate.month + 1, 0).day; // Días en el mes anterior
    }
    if (months < 0) {
      years--;
      months += 12;
    }

    return "Tienes $years años, $months meses y $days días.";
  }
}