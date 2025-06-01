sealed class InputBlocState {
  const InputBlocState();
}

class InitialInputBlocState extends InputBlocState {
  final double weight = 0.0;
  final double height = 0.0;

  const InitialInputBlocState();
}

class SuccessInputBlocState extends InputBlocState {
  final double weight;
  final double height;

  const SuccessInputBlocState({required this.weight, required this.height});
}

class ErrorInputBlocState extends InputBlocState {
  final double weight;
  final double height;
  final String? weightError;
  final String? heightError;

  const ErrorInputBlocState({
    required this.height,
    required this.weight,
    required this.weightError,
    required this.heightError,
  });
}
