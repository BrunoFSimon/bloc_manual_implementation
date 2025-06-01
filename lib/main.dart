import 'package:bloc_manual_implementation/blocs/input/input_bloc.dart';
import 'package:bloc_manual_implementation/providers/bloc_provider.dart';
import 'package:bloc_manual_implementation/providers/multi_bloc_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final InputBloc _inputBloc;

  @override
  void initState() {
    super.initState();

    _inputBloc = InputBloc();
  }

  @override
  void dispose() {
    _inputBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [(child) => BlocProvider(bloc: _inputBloc, child: child)],
      child: MaterialApp(),
    );
  }
}
