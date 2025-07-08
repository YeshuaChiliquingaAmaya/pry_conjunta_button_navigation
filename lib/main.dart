// lib/main.dart
import 'package:flutter/material.dart';
import 'package:pry_conjunta_button_navigation/pages/age_calculator_screen.dart';
import 'package:pry_conjunta_button_navigation/views/pages/triangle_checker_screen.dart';
import 'package:pry_conjunta_button_navigation/views/pages/user_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App con Navegación Inferior',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Usando la fuente Inter
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Índice de la pestaña seleccionada

  // Lista de widgets para cada pestaña, ahora importados de views/pages
  static const List<Widget> _widgetOptions = <Widget>[
    AgeCalculatorScreen(),
    TriangleCheckerScreen(),
    UserListScreen(),
  ];

  // Función para manejar el cambio de pestaña
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App con Navegación Inferior'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Center(
        // Muestra el widget correspondiente a la pestaña seleccionada
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cake_rounded),
            label: 'Edad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.change_history_rounded),
            label: 'Triángulo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api_rounded),
            label: 'API',
          ),
        ],
        currentIndex: _selectedIndex, // Índice actual
        selectedItemColor: Colors.blueAccent, // Color del ítem seleccionado
        unselectedItemColor: Colors.grey, // Color del ítem no seleccionado
        onTap: _onItemTapped, // Función al tocar un ítem
        backgroundColor: Colors.white,
        elevation: 10,
        type: BottomNavigationBarType.fixed, // Asegura que los ítems no se muevan
      ),
    );
  }
}
