sealed class InputBlocState {
  const InputBlocState();
}

class InitialInputBlocState extends InputBlocState {
  double? get weight => null;
  double? get height => null;

  const InitialInputBlocState();
}

class SuccessInputBlocState extends InputBlocState {
  final double weight;
  final double height;

  const SuccessInputBlocState({required this.weight, required this.height});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SuccessInputBlocState &&
        other.weight == weight &&
        other.height == height;
  }

  @override
  int get hashCode => weight.hashCode ^ height.hashCode;

  @override
  String toString() =>
      'SuccessInputBlocState(weight: $weight, height: $height)';
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorInputBlocState &&
        other.weight == weight &&
        other.height == height &&
        other.weightError == weightError &&
        other.heightError == heightError;
  }

  @override
  int get hashCode =>
      weight.hashCode ^
      height.hashCode ^
      weightError.hashCode ^
      heightError.hashCode;

  @override
  String toString() =>
      'ErrorInputBlocState(weight: $weight, height: $height, weightError: $weightError, heightError: $heightError)';
}
