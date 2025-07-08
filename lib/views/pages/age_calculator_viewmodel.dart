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
