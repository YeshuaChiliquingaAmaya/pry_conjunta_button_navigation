// --- lib/views/pages/user_list_screen.dart ---
import 'package:flutter/material.dart';
import 'package:pry_conjunta_button_navigation/models/user.dart'; // Importa el modelo User
import 'package:pry_conjunta_button_navigation/viewmodels/user_list_viewmodel.dart'; // Importa el ViewModel

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User>> _futureUsers; // Futuro que contendrá la lista de usuarios (estado UI local)

  final UserListViewModel _viewModel = UserListViewModel(); // Instancia del ViewModel

  @override
  void initState() {
    super.initState();
    _fetchUsersData(); // Inicia la carga de usuarios al inicializar el estado
  }

  // Función para obtener usuarios llamando al ViewModel
  void _fetchUsersData() {
    setState(() {
      _futureUsers = _viewModel.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _futureUsers, // El futuro que estamos esperando
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un indicador de carga mientras se obtienen los datos
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          );
        } else if (snapshot.hasError) {
          // Muestra un mensaje de error si algo sale mal
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 60),
                  const SizedBox(height: 15),
                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _fetchUsersData, // Reintentar la carga
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Reintentar'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasData) {
          // Si los datos se obtuvieron correctamente, muestra la lista
          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: snapshot.data!.length, // Número de usuarios en la lista
            itemBuilder: (context, index) {
              User user = snapshot.data![index]; // Usuario actual
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Bordes redondeados
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Icon(Icons.email_rounded, size: 18, color: Colors.grey),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              user.email,
                              style: const TextStyle(fontSize: 16.0, color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          const Icon(Icons.phone_rounded, size: 18, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(
                            user.phone,
                            style: const TextStyle(fontSize: 16.0, color: Colors.black87),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          const Icon(Icons.web_rounded, size: 18, color: Colors.grey),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              user.website,
                              style: const TextStyle(fontSize: 16.0, color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          // Caso por defecto si no hay datos ni error (ej. lista vacía)
          return const Center(
            child: Text(
              'No hay usuarios disponibles.',
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          );
        }
      },
    );
  }
}