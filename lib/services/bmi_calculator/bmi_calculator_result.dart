import 'package:bloc_manual_implementation/services/bmi_calculator/bmi_calculator_health_status_enum.dart';

class BMICalculatorResult {
  final double currentBMI;
  final BMICalculatorCategory category;

  BMICalculatorResult({required this.currentBMI, required this.category});
}
