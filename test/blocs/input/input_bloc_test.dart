import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_manual_implementation/blocs/input/input_bloc.dart';
import 'package:bloc_manual_implementation/blocs/input/input_bloc_event.dart';
import 'package:bloc_manual_implementation/blocs/input/input_bloc_state.dart';

void main() {
  group('InputBloc Tests', () {
    late InputBloc bloc;

    setUp(() {
      bloc = InputBloc();
    });

    tearDown(() {
      bloc.dispose();
    });

    test('emits [InitialInputBlocState] as the initial state', () {
      expect(bloc.stateStream, emits(const InitialInputBlocState()));
    });

    test(
      'emits [SuccessInputBlocState] when valid weight is set and height is initial',
      () {
        bloc.eventSink.add(const SetWeightInputEvent('70.5'));

        expectLater(
          bloc.stateStream,
          emitsInOrder([
            const InitialInputBlocState(),
            const SuccessInputBlocState(weight: 70.5, height: 0.0),
          ]),
        );
      },
    );

    test(
      'emits [ErrorInputBlocState] when invalid weight is set and height is initial',
      () {
        bloc.eventSink.add(const SetWeightInputEvent('abc'));
        expectLater(
          bloc.stateStream,
          emitsInOrder([
            const InitialInputBlocState(),
            const ErrorInputBlocState(
              weight: 0.0,
              height: 0.0,
              weightError: 'Peso inserido é inválido',
              heightError: null,
            ),
          ]),
        );
      },
    );

    test(
      'emits [SuccessInputBlocState] when valid height is set and weight is initial',
      () {
        bloc.eventSink.add(const SetHeightInputEvent('1.75'));
        expectLater(
          bloc.stateStream,
          emitsInOrder([
            const InitialInputBlocState(),
            const SuccessInputBlocState(weight: 0.0, height: 1.75),
          ]),
        );
      },
    );

    test(
      'emits [ErrorInputBlocState] when invalid height is set and weight is initial',
      () {
        bloc.eventSink.add(const SetHeightInputEvent('xyz'));
        expectLater(
          bloc.stateStream,
          emitsInOrder([
            const InitialInputBlocState(),
            const ErrorInputBlocState(
              weight: 0.0,
              height: 0.0,
              weightError: null,
              heightError: 'Altura inserida é inválida',
            ),
          ]),
        );
      },
    );

    test(
      'emits [SuccessInputBlocState] for valid weight then valid height',
      () {
        expectLater(
          bloc.stateStream,
          emitsInOrder([
            const InitialInputBlocState(),
            const SuccessInputBlocState(
              weight: 70.0,
              height: 0.0,
            ), // After weight
            const SuccessInputBlocState(
              weight: 70.0,
              height: 1.75,
            ), // After height
          ]),
        );

        bloc.eventSink.add(const SetWeightInputEvent('70'));
        bloc.eventSink.add(const SetHeightInputEvent('1.75'));
      },
    );

    test(
      'emits [ErrorInputBlocState] for valid weight then invalid height',
      () {
        expectLater(
          bloc.stateStream,
          emitsInOrder([
            const InitialInputBlocState(),
            const SuccessInputBlocState(weight: 70.0, height: 0.0),
            const ErrorInputBlocState(
              weight: 70.0, // Last valid weight
              height: 0.0, // Height parse failed, keeps previous
              weightError: null,
              heightError: 'Altura inserida é inválida',
            ),
          ]),
        );
        bloc.eventSink.add(const SetWeightInputEvent('70'));
        bloc.eventSink.add(const SetHeightInputEvent('xyz'));
      },
    );

    test(
      'emits [ErrorInputBlocState] for invalid weight then valid height',
      () {
        expectLater(
          bloc.stateStream,
          emitsInOrder([
            const InitialInputBlocState(),
            const ErrorInputBlocState(
              // After invalid weight
              weight: 0.0,
              height: 0.0,
              weightError: 'Peso inserido é inválido',
              heightError: null,
            ),
            const ErrorInputBlocState(
              // After valid height, but weight error persists
              weight: 0.0, // Weight parse failed, keeps previous
              height: 1.75, // Height is now valid
              weightError: 'Peso inserido é inválido',
              heightError: null, // Height error is cleared
            ),
          ]),
        );
        bloc.eventSink.add(const SetWeightInputEvent('abc'));
        bloc.eventSink.add(const SetHeightInputEvent('1.75'));
      },
    );
  });
}
