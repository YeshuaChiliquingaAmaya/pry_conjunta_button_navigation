// --- lib/viewmodels/user_list_viewmodel.dart ---
import 'package:pry_conjunta_button_navigation/models/user.dart';
import 'package:pry_conjunta_button_navigation/services/api_service.dart';

// Este ViewModel se encarga de la lógica de negocio y la gestión de datos para la lista de usuarios.
class UserListViewModel {
  // Método para obtener la lista de usuarios de la API a través del ApiService.
  Future<List<User>> fetchUsers() async {
    try {
      return await ApiService.fetchUsers();
    } catch (e) {
      // Re-lanzar la excepción para que la UI pueda manejarla
      throw Exception('Error al obtener usuarios: $e');
    }
  }
}