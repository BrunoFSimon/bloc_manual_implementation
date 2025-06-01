sealed class InputBlocEvent {
  const InputBlocEvent();
}

class SetWeightInputEvent extends InputBlocEvent {
  final String weight;

  const SetWeightInputEvent(this.weight);
}

class SetHeightInputEvent extends InputBlocEvent {
  final String height;

  const SetHeightInputEvent(this.height);
}
