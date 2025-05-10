import 'package:flutter_riverpod/flutter_riverpod.dart';


//Family providers for quick usage.
//Every family member is identified by a unique string
final intProvider = StateProvider.family<int, String>(
  (_, __) => 0
);



final stringProvider = StateProvider.family<String, String>(
  (_, __) => ''
);



final boolProvider = StateProvider.family<bool, String>(
  (_, __) => false
);



final objectProvider = StateProvider.family<Object?, String>(
  (_, __) => null
);