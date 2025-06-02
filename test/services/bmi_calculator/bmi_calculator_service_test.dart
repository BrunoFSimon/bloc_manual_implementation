import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_manual_implementation/blocs/bmi_calculator/bmi_calculator_bloc.dart';
import 'package:bloc_manual_implementation/blocs/bmi_calculator/bmi_calculator_bloc_event.dart';
import 'package:bloc_manual_implementation/blocs/bmi_calculator/bmi_calculator_bloc_state.dart';
import 'package:bloc_manual_implementation/services/bmi_calculator/bmi_calculator_health_status_enum.dart';
import 'package:bloc_manual_implementation/services/bmi_calculator/bmi_calculator_result.dart';
import 'package:bloc_manual_implementation/services/bmi_calculator/bmi_calculator_service.dart';

class MockBMICalculatorService extends Mock implements BMICalculatorService {}

void main() {
  late MockBMICalculatorService mockService;
  late BMICalculatorBloc bloc;

  setUp(() {
    mockService = MockBMICalculatorService();
    bloc = BMICalculatorBloc(bmiCalculatorService: mockService);

    registerFallbackValue(0.0);
  });

  tearDown(() {
    bloc.dispose();
  });

  test('initial state is InitialBMICalculatorBlocState', () async {
    expect(await bloc.stateStream.first, isA<InitialBMICalculatorBlocState>());
  });

  test('emits Loading and Success on valid Calculate event', () async {
    when(() => mockService.calculateBMI(1.75, 72)).thenAnswer(
      (_) async => BMICalculatorResult(
        currentBMI: 23.5,
        category: BMICalculatorCategory.normal,
      ),
    );
    final states = bloc.stateStream.skip(1);
    bloc.eventSink.add(
      const BMICalculatorBlocCalculateEvent(weight: 72, height: 1.75),
    );
    await expectLater(
      states,
      emitsInOrder([
        isA<LoadingBMICalculatorBlocState>(),
        predicate<SuccessBMICalculatorBlocState>(
          (s) =>
              (s.currentBMI - 23.5).abs() < 0.01 &&
              s.category == BMICalculatorCategory.normal,
        ),
      ]),
    );
    verify(() => mockService.calculateBMI(1.75, 72)).called(1);
  });

  test('emits Error on Calculate event with zero/negative input', () async {
    final states = bloc.stateStream.skip(1);
    bloc.eventSink.add(
      const BMICalculatorBlocCalculateEvent(weight: 0, height: 1.75),
    );
    await expectLater(
      states,
      emits(
        predicate<ErrorBMICalculatorBlocState>(
          (s) => s.errorMessage.contains('greater than zero'),
        ),
      ),
    );
  });

  test('emits Error on Calculate event when service throws', () async {
    when(
      () => mockService.calculateBMI(1.75, 72),
    ).thenThrow(Exception('Fake error'));
    final states = bloc.stateStream.skip(1);
    bloc.eventSink.add(
      const BMICalculatorBlocCalculateEvent(weight: 72, height: 1.75),
    );
    await expectLater(
      states,
      emitsInOrder([
        isA<LoadingBMICalculatorBlocState>(),
        predicate<ErrorBMICalculatorBlocState>(
          (s) => s.errorMessage.contains('An error occurred'),
        ),
      ]),
    );
    verify(() => mockService.calculateBMI(1.75, 72)).called(1);
  });

  test('emits Initial state on Reset event', () async {
    final states = bloc.stateStream.skip(1);
    bloc.eventSink.add(const BMICalculatorBlocResetEvent());
    await expectLater(states, emits(isA<InitialBMICalculatorBlocState>()));
  });

  test('multiple Calculate events emit correct states in order', () async {
    when(() => mockService.calculateBMI(1.80, 80)).thenAnswer(
      (_) async => BMICalculatorResult(
        currentBMI: 24.7,
        category: BMICalculatorCategory.normal,
      ),
    );
    when(() => mockService.calculateBMI(1.60, 100)).thenAnswer(
      (_) async => BMICalculatorResult(
        currentBMI: 39.1,
        category: BMICalculatorCategory
            .obeseClass2, // 39.1 falls in 35.0 <= BMI < 40.0
      ),
    );
    final states = bloc.stateStream.skip(1);
    bloc.eventSink.add(
      const BMICalculatorBlocCalculateEvent(weight: 80, height: 1.80),
    );
    bloc.eventSink.add(
      const BMICalculatorBlocCalculateEvent(weight: 100, height: 1.60),
    );
    await expectLater(
      states,
      emitsInOrder([
        isA<LoadingBMICalculatorBlocState>(),
        predicate<SuccessBMICalculatorBlocState>(
          (s) =>
              (s.currentBMI - 24.7).abs() < 0.01 &&
              s.category == BMICalculatorCategory.normal,
        ),
        isA<LoadingBMICalculatorBlocState>(),
        predicate<SuccessBMICalculatorBlocState>(
          (s) =>
              (s.currentBMI - 39.1).abs() < 0.01 &&
              s.category == BMICalculatorCategory.obeseClass2,
        ),
      ]),
    );
    verify(() => mockService.calculateBMI(1.80, 80)).called(1);
    verify(() => mockService.calculateBMI(1.60, 100)).called(1);
  });

  test('Reset after Success returns to Initial state', () async {
    when(() => mockService.calculateBMI(1.75, 72)).thenAnswer(
      (_) async => BMICalculatorResult(
        currentBMI: 23.5,
        category: BMICalculatorCategory.normal,
      ),
    );

    final states = bloc.stateStream;

    bloc.eventSink.add(
      const BMICalculatorBlocCalculateEvent(weight: 72, height: 1.75),
    );

    bloc.eventSink.add(const BMICalculatorBlocResetEvent());

    await expectLater(
      states,
      emitsInOrder([
        isA<LoadingBMICalculatorBlocState>(),
        isA<SuccessBMICalculatorBlocState>(),
        isA<InitialBMICalculatorBlocState>(),
      ]),
    );
  });

  test('Calculate event with negative height emits Error', () async {
    final states = bloc.stateStream.skip(1);
    bloc.eventSink.add(
      const BMICalculatorBlocCalculateEvent(weight: 70, height: -1.70),
    );
    await expectLater(
      states,
      emits(
        predicate<ErrorBMICalculatorBlocState>(
          (s) => s.errorMessage.contains('greater than zero'),
        ),
      ),
    );
    verifyNever(() => mockService.calculateBMI(any(), any()));
  });
}
