// --- lib/viewmodels/triangle_checker_viewmodel.dart ---
// No necesita importaciones de Flutter UI aquí
class TriangleCheckerViewModel {
  // Método para determinar el tipo de triángulo
  String checkTriangleType(String sideAtext, String sideBtext, String sideCtext) {
    final double? sideA = double.tryParse(sideAtext);
    final double? sideB = double.tryParse(sideBtext);
    final double? sideC = double.tryParse(sideCtext);

    if (sideA == null || sideB == null || sideC == null || sideA <= 0 || sideB <= 0 || sideC <= 0) {
      return "Por favor, ingresa valores válidos y positivos para los tres lados.";
    }

    // Comprobar la desigualdad del triángulo
    if (sideA + sideB <= sideC || sideA + sideC <= sideB || sideB + sideC <= sideA) {
      return "Estos lados no pueden formar un triángulo.";
    }

    if (sideA == sideB && sideB == sideC) {
      return "Es un triángulo Equilátero.";
    } else if (sideA == sideB || sideA == sideC || sideB == sideC) {
      return "Es un triángulo Isósceles.";
    } else {
      return "Es un triángulo Escaleno.";
    }
  }
}