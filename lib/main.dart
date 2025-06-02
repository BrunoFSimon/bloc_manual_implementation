import 'package:bloc_manual_implementation/blocs/bmi_calculator/bmi_calculator_bloc.dart';
import 'package:bloc_manual_implementation/blocs/input/input_bloc.dart';
import 'package:bloc_manual_implementation/components/provider/provider.dart';
import 'package:bloc_manual_implementation/components/provider/multi_provider.dart';
import 'package:bloc_manual_implementation/pages/calculator/calculator_widget.dart';
import 'package:bloc_manual_implementation/services/bmi_calculator/bmi_calculator_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // TODO improve it to insert directly in the provider's list with auto dispose pattern
  late final InputBloc _inputBloc;
  late final BMICalculatorService _bmiCalculatorService;
  late final BMICalculatorBloc _bmiCalculatorBloc;

  @override
  void initState() {
    super.initState();

    _inputBloc = InputBloc();
    _bmiCalculatorService = BMICalculatorService();
    _bmiCalculatorBloc = BMICalculatorBloc(
      bmiCalculatorService: _bmiCalculatorService,
    );
  }

  @override
  void dispose() {
    _inputBloc.dispose();
    _bmiCalculatorService.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: MultiProvider(
        providers: [
          (child) => Provider(instance: _inputBloc, child: child),
          (child) => Provider(instance: _bmiCalculatorService, child: child),
          (child) => Provider(instance: _bmiCalculatorBloc, child: child),
        ],
        child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.grey,
            textTheme: GoogleFonts.gabaritoTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: CalculatorWidget(),
        ),
      ),
    );
  }
}
