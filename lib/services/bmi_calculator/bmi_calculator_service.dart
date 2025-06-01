import 'package:bloc_manual_implementation/services/bmi_calculator/bmi_calculator_health_status_enum.dart';
import 'package:bloc_manual_implementation/services/bmi_calculator/bmi_calculator_result.dart';

class BMICalculatorService {
  Future<BMICalculatorResult> calculateBMI(double height, double weight) async {
    await Future.delayed(Duration(seconds: 1));

    final bmi = weight / (height * height);

    final category = BMICalculatorCategory.values.firstWhere(
      (c) => c.range.contains(bmi),
    );

    return BMICalculatorResult(currentBMI: bmi, category: category);
  }
}
