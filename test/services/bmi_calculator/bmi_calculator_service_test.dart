import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_manual_implementation/services/bmi_calculator/bmi_calculator_service.dart';
import 'package:bloc_manual_implementation/services/bmi_calculator/bmi_calculator_health_status_enum.dart';

void main() {
  final service = BMICalculatorService();

  Future<void> expectBMI({
    required double height,
    required double weight,
    required double expectedBMI,
    required BMICalculatorCategory expectedCategory,
  }) async {
    final result = await service.calculateBMI(height, weight);
    expect(result.currentBMI, closeTo(expectedBMI, 0.01));
    expect(result.category, expectedCategory);
  }

  test('calculates Severely Underweight', () async {
    await expectBMI(
      height: 1.75,
      weight: 48.0, // BMI ≈ 15.67
      expectedBMI: 15.67,
      expectedCategory: BMICalculatorCategory.severelyUnderweight,
    );
  });

  test('calculates Moderately Underweight', () async {
    await expectBMI(
      height: 1.75,
      weight: 49.0, // BMI ≈ 16.00
      expectedBMI: 16.00,
      expectedCategory: BMICalculatorCategory.moderatelyUnderweight,
    );
  });

  test('calculates Mildly Underweight', () async {
    await expectBMI(
      height: 1.748,
      weight: 52.0, // BMI ≈ 17.01
      expectedBMI: 17.01,
      expectedCategory: BMICalculatorCategory.mildlyUnderweight,
    );
  });

  test('calculates Normal', () async {
    await expectBMI(
      height: 1.75,
      weight: 70.0, // BMI ≈ 22.86
      expectedBMI: 22.86,
      expectedCategory: BMICalculatorCategory.normal,
    );
  });

  test('calculates Overweight', () async {
    await expectBMI(
      height: 1.75,
      weight: 80.0, // BMI ≈ 26.12
      expectedBMI: 26.12,
      expectedCategory: BMICalculatorCategory.overweight,
    );
  });

  test('calculates Obese Class I', () async {
    await expectBMI(
      height: 1.75,
      weight: 95.0, // BMI ≈ 31.02
      expectedBMI: 31.02,
      expectedCategory: BMICalculatorCategory.obeseClass1,
    );
  });

  test('calculates Obese Class II', () async {
    await expectBMI(
      height: 1.75,
      weight: 110.0, // BMI ≈ 35.92
      expectedBMI: 35.92,
      expectedCategory: BMICalculatorCategory.obeseClass2,
    );
  });

  test('calculates Obese Class III', () async {
    await expectBMI(
      height: 1.75,
      weight: 130.0, // BMI ≈ 42.45
      expectedBMI: 42.45,
      expectedCategory: BMICalculatorCategory.obeseClass3,
    );
  });
}
