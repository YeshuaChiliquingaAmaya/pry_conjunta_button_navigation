// --- lib/views/pages/age_calculator_screen.dart ---
import 'package:flutter/material.dart';
import 'package:pry_conjunta_button_navigation/views/pages/age_calculator_viewmodel.dart'; // Importa el ViewModel

class AgeCalculatorScreen extends StatefulWidget {
  const AgeCalculatorScreen({super.key});

  @override
  State<AgeCalculatorScreen> createState() => _AgeCalculatorScreenState();
}

class _AgeCalculatorScreenState extends State<AgeCalculatorScreen> {
  DateTime? _selectedDate; // Fecha de nacimiento seleccionada (estado UI local)
  String _ageResult = "Selecciona tu fecha de nacimiento"; // Resultado de la edad (estado UI local)

  final AgeCalculatorViewModel _viewModel = AgeCalculatorViewModel(); // Instancia del ViewModel

  // Función para mostrar el selector de fecha y actualizar el estado
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Fecha inicial del selector
      firstDate: DateTime(1900), // Fecha mínima
      lastDate: DateTime.now(), // Fecha máxima (hoy)
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blueAccent, // Color de la cabecera
            colorScheme: const ColorScheme.light(primary: Colors.blueAccent), // Color de los elementos seleccionados
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), // Bordes redondeados
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // Llama al ViewModel para calcular la edad y actualiza el estado local
        _ageResult = _viewModel.calculateAge(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Texto que muestra la fecha seleccionada
          Text(
            _selectedDate == null
                ? 'Ninguna fecha seleccionada'
                : 'Fecha de nacimiento: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20.0),
          // Botón para seleccionar la fecha
          ElevatedButton.icon(
            onPressed: () => _selectDate(context),
            icon: const Icon(Icons.calendar_today_rounded),
            label: const Text('Seleccionar Fecha de Nacimiento'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Bordes redondeados
              ),
              elevation: 5,
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30.0),
          // Muestra el resultado de la edad
          Text(
            _ageResult,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
        ],
      ),
    );
  }
}
