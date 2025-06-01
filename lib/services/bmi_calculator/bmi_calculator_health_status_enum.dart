enum BMICalculatorCategory {
  severelyUnderweight,
  moderatelyUnderweight,
  mildlyUnderweight,
  normal,
  overweight,
  obeseClass1,
  obeseClass2,
  obeseClass3,
}

extension BMICalculatorCategoryExtension on BMICalculatorCategory {
  BMICalculatorCategoryRange get range {
    switch (this) {
      case BMICalculatorCategory.severelyUnderweight:
        return BMICalculatorCategoryRange(
          min: double.negativeInfinity,
          max: 16.0,
        );
      case BMICalculatorCategory.moderatelyUnderweight:
        return BMICalculatorCategoryRange(min: 16.0, max: 17.0);
      case BMICalculatorCategory.mildlyUnderweight:
        return BMICalculatorCategoryRange(min: 17.0, max: 18.5);
      case BMICalculatorCategory.normal:
        return BMICalculatorCategoryRange(min: 18.5, max: 25.0);
      case BMICalculatorCategory.overweight:
        return BMICalculatorCategoryRange(min: 25.0, max: 30.0);
      case BMICalculatorCategory.obeseClass1:
        return BMICalculatorCategoryRange(min: 30.0, max: 35.0);
      case BMICalculatorCategory.obeseClass2:
        return BMICalculatorCategoryRange(min: 35.0, max: 40.0);
      case BMICalculatorCategory.obeseClass3:
        return BMICalculatorCategoryRange(min: 40.0, max: double.infinity);
    }
  }

  String get description {
    switch (this) {
      case BMICalculatorCategory.severelyUnderweight:
        return 'Severely Underweight';
      case BMICalculatorCategory.moderatelyUnderweight:
        return 'Moderately Underweight';
      case BMICalculatorCategory.mildlyUnderweight:
        return 'Mildly Underweight';
      case BMICalculatorCategory.normal:
        return 'Normal';
      case BMICalculatorCategory.overweight:
        return 'Overweight';
      case BMICalculatorCategory.obeseClass1:
        return 'Obese Class I (Moderate)';
      case BMICalculatorCategory.obeseClass2:
        return 'Obese Class II (Severe)';
      case BMICalculatorCategory.obeseClass3:
        return 'Obese Class III (Very Severe/Morbid)';
    }
  }
}

class BMICalculatorCategoryRange {
  final double min;
  final double max;

  BMICalculatorCategoryRange({required this.min, required this.max});

  bool contains(double bmi) {
    return bmi >= min && bmi < max;
  }
}
