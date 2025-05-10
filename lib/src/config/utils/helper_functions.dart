import 'dart:async';
import 'dart:math';
import 'package:contact_alarm/src/config/utils/extensions/context_extensions.dart';

import '../../global_export.dart';

class AfriHelperFuncs{
  const AfriHelperFuncs._();

  
  static int getRandomNumber(double ceiling){
    final int number = Random().nextInt(ceiling.toInt()) + 1;
    if(number < 100){
      return 100 + number;
    }
    return number;
  }

  static setAProvider({
    BuildContext? context,
    required StateProvider provider,
    required dynamic value,
    WidgetRef? widgetRef,
    Ref? ref,
    int? duration
  }){
    dynamic reference;
    if(widgetRef != null){
      reference = widgetRef;
    }
    else if(ref != null){
      reference = ref;
    }
    else{
      reference = context!.getRef;
    }
    Future.delayed(
      Duration(milliseconds: duration ?? 0),
      () => reference.read(provider.notifier).state = value
    );
  }


  static Timer? _debounce;
  static void callDebouncer(int duration, Function func, [List<dynamic>? args]) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(
      Duration(milliseconds: duration),
      () {
        if (args != null) {Function.apply(func, args);}
        else {func();}
      }
    );
  }

  static void disposeDebouncer() {
    _debounce?.cancel();
  }

}