import 'package:flutter/services.dart';
import '../global_export.dart';

class AfriAnnotatedRegion extends StatelessWidget {
  final Widget child;

  const AfriAnnotatedRegion({
    super.key,
    required this.child,
  });

  @override
  Widget build(context) {
    final brightness = context.getBrightness;
    final inDarkMode = brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: !inDarkMode ? AfriColors.white : AfriColors.black,
        statusBarColor: inDarkMode ? AfriColors.black : AfriColors.white,
        statusBarIconBrightness: inDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness: inDarkMode ? Brightness.light : Brightness.dark,
      ),
      child: child
    );
  }
}