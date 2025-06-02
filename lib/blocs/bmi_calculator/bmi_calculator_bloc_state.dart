import 'package:bloc_manual_implementation/services/bmi_calculator/bmi_calculator_health_status_enum.dart';

sealed class BMICalculatorBlocState {
  const BMICalculatorBlocState();
}

class InitialBMICalculatorBlocState extends BMICalculatorBlocState {
  const InitialBMICalculatorBlocState();
}

class SuccessBMICalculatorBlocState extends BMICalculatorBlocState {
  final double currentBMI;
  final BMICalculatorCategory category;

  const SuccessBMICalculatorBlocState({
    required this.currentBMI,
    required this.category,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SuccessBMICalculatorBlocState &&
        other.currentBMI == currentBMI &&
        other.category == category;
  }

  @override
  int get hashCode => currentBMI.hashCode ^ category.hashCode;

  @override
  String toString() =>
      'SuccessBMICalculatorBlocState(currentBMI: $currentBMI, category: $category)';
}

class ErrorBMICalculatorBlocState extends BMICalculatorBlocState {
  final String errorMessage;

  const ErrorBMICalculatorBlocState({required this.errorMessage});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ErrorBMICalculatorBlocState &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;

  @override
  String toString() =>
      'ErrorBMICalculatorBlocState(errorMessage: $errorMessage)';
}

class LoadingBMICalculatorBlocState extends BMICalculatorBlocState {
  const LoadingBMICalculatorBlocState();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoadingBMICalculatorBlocState;
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'LoadingBMICalculatorBlocState()';
}
