import 'package:flutter/widgets.dart';

class Provider<T extends Object> extends InheritedWidget {
  final T instance;

  const Provider({super.key, required this.instance, required super.child});

  static T of<T extends Object>(BuildContext context) {
    final Provider<T>? result = context
        .dependOnInheritedWidgetOfExactType<Provider<T>>();

    if (result == null) {
      throw FlutterError('Fail: Provider.of<$T>()');
    }

    return result.instance;
  }

  @override
  bool updateShouldNotify(Provider<T> oldWidget) =>
      instance != oldWidget.instance;
}
