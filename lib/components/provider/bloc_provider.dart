import 'package:flutter/widgets.dart';

class BlocProvider<T extends Object> extends InheritedWidget {
  final T bloc;

  const BlocProvider({super.key, required this.bloc, required super.child});

  static T of<T extends Object>(BuildContext context) {
    final BlocProvider<T>? result = context
        .dependOnInheritedWidgetOfExactType<BlocProvider<T>>();

    if (result == null) {
      throw FlutterError('Fail: BlocProvider.of<$T>()');
    }

    return result.bloc;
  }

  @override
  bool updateShouldNotify(BlocProvider<T> oldWidget) => bloc != oldWidget.bloc;
}
