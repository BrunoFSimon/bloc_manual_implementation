import 'package:bloc_manual_implementation/blocs/input/input_bloc.dart';
import 'package:bloc_manual_implementation/blocs/input/input_bloc_event.dart';
import 'package:bloc_manual_implementation/blocs/input/input_bloc_state.dart';
import 'package:bloc_manual_implementation/components/provider/bloc_provider.dart';
import 'package:bloc_manual_implementation/widgets/app_filled_button.dart';
import 'package:bloc_manual_implementation/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class CalculatorWidget extends StatelessWidget {
  const CalculatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final inputBloc = BlocProvider.of<InputBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: StreamBuilder(
              stream: inputBloc.stateStream,
              builder: (context, snapshot) {
                late final double? weight;
                late final double? height;

                late final String? weightError;
                late final String? heightError;

                switch (snapshot.data) {
                  case null:
                    weight = null;
                    height = null;
                    weightError = null;
                    heightError = null;
                    break;
                  case InitialInputBlocState():
                    final state = snapshot.data as InitialInputBlocState;
                    weight = state.weight;
                    height = state.height;
                    weightError = null;
                    heightError = null;
                    break;
                  case SuccessInputBlocState():
                    final state = snapshot.data as SuccessInputBlocState;
                    weight = state.weight;
                    height = state.height;
                    weightError = null;
                    heightError = null;
                    break;
                  case ErrorInputBlocState():
                    final state = snapshot.data as ErrorInputBlocState;
                    weight = state.weight;
                    height = state.height;
                    weightError = state.weightError;
                    heightError = state.heightError;
                    break;
                }

                return Column(
                  spacing: 16,
                  children: [
                    AppTextFormField(
                      onChanged: (v) {
                        inputBloc.eventSink.add(SetWeightInputEvent(v));
                      },
                      initialValue: weight?.toString(),
                      errorText: weightError,
                      label: 'Weight',
                      hint: 'Ex: 1.70',
                    ),
                    AppTextFormField(
                      onChanged: (v) {
                        inputBloc.eventSink.add(SetHeightInputEvent(v));
                      },
                      initialValue: height?.toString(),
                      errorText: heightError,
                      label: 'Height',
                      hint: 'Ex: 70.00',
                    ),
                    AppFilledButton(text: 'Calculate', onPressed: () {}),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
