import 'dart:async';
import 'package:bloc_manual_implementation/blocs/input/input_bloc_event.dart';
import 'package:bloc_manual_implementation/blocs/input/input_bloc_state.dart';

class InputBloc {
  double _weight = 0.0;
  double _height = 0.0;

  String? _weightError;
  String? _heightError;

  final _eventController = StreamController<InputBlocEvent>();
  Sink<InputBlocEvent> get eventSink => _eventController.sink;

  final _stateController = StreamController<InputBlocState>();
  Stream<InputBlocState> get stateStream => _stateController.stream;

  InputBloc() {
    _eventController.stream.listen(_mapEventToState);

    _stateController.add(const InitialInputBlocState());
  }

  void _mapEventToState(InputBlocEvent event) {
    switch (event) {
      case SetWeightInputEvent():
        _handleSetWeightInputEvent(event);
        break;
      case SetHeightInputEvent():
        _handleSetHeightInputEvent(event);
        break;
    }
  }

  void _handleSetHeightInputEvent(SetHeightInputEvent event) {
    _heightError = null;

    final value = double.tryParse(event.height);

    if (value == null) {
      _heightError = 'Inserted height is invalid';
    } else {
      _height = value;
    }

    _emitCurrentState();
  }

  void _handleSetWeightInputEvent(SetWeightInputEvent event) {
    _weightError = null;

    final value = double.tryParse(event.weight);

    if (value == null) {
      /// TODO criar um arquivo com essas mensagens de erro para
      /// facilitar comparações nos testes
      _weightError = 'Inserted weight is invalid';
    } else {
      _weight = value;
    }

    _emitCurrentState();
  }

  void _emitCurrentState() {
    if (_heightError != null || _weightError != null) {
      _stateController.add(
        ErrorInputBlocState(
          height: _height,
          weight: _weight,
          weightError: _weightError,
          heightError: _heightError,
        ),
      );
    } else {
      _stateController.add(
        SuccessInputBlocState(height: _height, weight: _weight),
      );
    }
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
