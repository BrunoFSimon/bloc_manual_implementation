import 'dart:async';

import 'package:bloc_manual_implementation/blocs/bmi_calculator/bmi_calculator_bloc_event.dart';
import 'package:bloc_manual_implementation/blocs/bmi_calculator/bmi_calculator_bloc_state.dart';
import 'package:bloc_manual_implementation/services/bmi_calculator/bmi_calculator_service.dart';

class BMICalculatorBloc {
  final BMICalculatorService _calculatorService;

  final _eventController = StreamController<BMICalculatorBlocEvent>();
  Sink<BMICalculatorBlocEvent> get eventSink => _eventController.sink;

  final _stateController = StreamController<BMICalculatorBlocState>.broadcast();
  Stream<BMICalculatorBlocState> get stateStream => _stateController.stream;

  BMICalculatorBloc({required BMICalculatorService bmiCalculatorService})
    : _calculatorService = bmiCalculatorService {
    _eventController.stream.listen(_mapEventToState);
    _stateController.add(const InitialBMICalculatorBlocState());
  }

  void _mapEventToState(BMICalculatorBlocEvent event) {
    switch (event) {
      case BMICalculatorBlocCalculateEvent():
        _handleCalculateEvent(event);
        break;
      case BMICalculatorBlocResetEvent():
        _handleResetEvent(event);
        break;
    }
  }

  Future<void> _handleCalculateEvent(
    BMICalculatorBlocCalculateEvent event,
  ) async {
    final height = event.height;
    final weight = event.weight;

    if (height <= 0 || weight <= 0) {
      _stateController.add(
        ErrorBMICalculatorBlocState(
          errorMessage: 'Height and weight must be greater than zero.',
        ),
      );
      return;
    }

    _stateController.add(const LoadingBMICalculatorBlocState());

    try {
      final result = await _calculatorService.calculateBMI(height, weight);

      _stateController.add(
        SuccessBMICalculatorBlocState(
          currentBMI: result.currentBMI,
          category: result.category,
        ),
      );
    } catch (e) {
      _stateController.add(
        ErrorBMICalculatorBlocState(
          errorMessage: 'An error occurred while calculating BMI: $e',
        ),
      );
    }
  }

  void _handleResetEvent(BMICalculatorBlocResetEvent event) {
    _stateController.add(const InitialBMICalculatorBlocState());
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
