import 'dart:ui';
import 'src/global_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveContactService.intializeHive();
  await NotificationService.initializeNotification();

  runApp(const ProviderScope(child: AfriApp()));
}


class AfriApp extends StatelessWidget {
  const AfriApp({super.key});

  @override
  Widget build(context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(0.83),
      ),
      child: MaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          },
        ),
        debugShowCheckedModeBanner: false,
        darkTheme: AfriThemeData.darkTheme,
        theme: AfriThemeData.lightTheme,
        home: const AfriHomeScreen(),
      ),
    );
  }
}




class AfriRouteTransiton<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Offset? beginOffset;

  AfriRouteTransiton({
    required this.child,
    this.beginOffset,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(
        begin: beginOffset ?? const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));

      return SlideTransition(
        position: tween,
        child: child,
      );
    },
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionDuration: const Duration(milliseconds: 200),
  );
}