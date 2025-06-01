import 'package:flutter/widgets.dart';

typedef ProviderBuilder = Widget Function(Widget child);

class MultiProvider extends StatelessWidget {
  final List<ProviderBuilder> providers;

  final Widget child;

  const MultiProvider({
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
