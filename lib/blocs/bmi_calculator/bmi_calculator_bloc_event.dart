sealed class BMICalculatorBlocEvent {
  const BMICalculatorBlocEvent();
}

class BMICalculatorBlocCalculateEvent extends BMICalculatorBlocEvent {
  final double weight;
  final double height;

  const BMICalculatorBlocCalculateEvent({
    required this.weight,
    required this.height,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BMICalculatorBlocCalculateEvent &&
        other.weight == weight &&
        other.height == height;
  }

  @override
  int get hashCode => weight.hashCode ^ height.hashCode;

  @override
  String toString() =>
      'BMICalculatorBlocCalculateEvent(weight: $weight, height: $height)';
}

class BMICalculatorBlocResetEvent extends BMICalculatorBlocEvent {
  const BMICalculatorBlocResetEvent();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BMICalculatorBlocResetEvent;
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'BMICalculatorBlocResetEvent()';
}
