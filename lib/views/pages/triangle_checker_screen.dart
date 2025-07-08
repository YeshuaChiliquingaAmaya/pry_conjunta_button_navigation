// --- lib/views/pages/triangle_checker_screen.dart ---
import 'package:flutter/material.dart';
import 'package:pry_conjunta_button_navigation/viewmodels/triangle_checker_viewmodel.dart'; // Importa el ViewModel

class TriangleCheckerScreen extends StatefulWidget {
  const TriangleCheckerScreen({super.key});

  @override
  State<TriangleCheckerScreen> createState() => _TriangleCheckerScreenState();
}

class _TriangleCheckerScreenState extends State<TriangleCheckerScreen> {
  final TextEditingController _sideAController = TextEditingController();
  final TextEditingController _sideBController = TextEditingController();
  final TextEditingController _sideCController = TextEditingController();
  String _triangleType = "Ingresa los tres lados del triángulo."; // Resultado (estado UI local)

  final TriangleCheckerViewModel _viewModel = TriangleCheckerViewModel(); // Instancia del ViewModel

  // Función para determinar el tipo de triángulo y actualizar el estado
  void _checkTriangleType() {
    setState(() {
      // Llama al ViewModel para obtener el resultado y actualiza el estado local
      _triangleType = _viewModel.checkTriangleType(
        _sideAController.text,
        _sideBController.text,
        _sideCController.text,
      );
    });
  }

  @override
  void dispose() {
    _sideAController.dispose();
    _sideBController.dispose();
    _sideCController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Campo de texto para el lado A
          _buildTextField(_sideAController, 'Lado A'),
          const SizedBox(height: 15.0),
          // Campo de texto para el lado B
          _buildTextField(_sideBController, 'Lado B'),
          const SizedBox(height: 15.0),
          // Campo de texto para el lado C
          _buildTextField(_sideCController, 'Lado C'),
          const SizedBox(height: 30.0),
          // Botón para verificar el tipo de triángulo
          ElevatedButton.icon(
            onPressed: _checkTriangleType,
            icon: const Icon(Icons.check_circle_rounded),
            label: const Text('Verificar Triángulo'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Bordes redondeados
              ),
              elevation: 5,
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30.0),
          // Muestra el resultado del tipo de triángulo
          Text(
            _triangleType,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
        ],
      ),
    );
  }

  // Helper para construir los campos de texto
  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: 'Ingresa la longitud del $labelText',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}