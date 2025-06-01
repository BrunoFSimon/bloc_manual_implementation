import 'package:flutter/widgets.dart';

typedef BlocProviderBuilder = Widget Function(Widget child);

class MultiBlocProvider extends StatelessWidget {
  final List<BlocProviderBuilder> providers;

  final Widget child;

  const MultiBlocProvider({
    super.key,
    required this.providers,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget result = child;

    for (final providerBuilder in providers.reversed) {
      result = providerBuilder(result);
    }

    return result;
  }
}
