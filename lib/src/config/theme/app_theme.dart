import '../../global_export.dart';

class AfriThemeData{
  const AfriThemeData._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: AfriStrings.AXIFORMA,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AfriColors.white,
    textTheme: AfriTextTheme.lightTextTheme,
    inputDecorationTheme: AfriInputDecorationTheme.lightInputDecorationTheme,
    appBarTheme: AfriAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: AfriElevatedButtonTheme.lightElevatedButtonTheme
  );


  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: AfriStrings.AXIFORMA,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AfriColors.black,
    textTheme: AfriTextTheme.darkTextTheme,
    inputDecorationTheme: AfriInputDecorationTheme.darkInputDecorationTheme,
    appBarTheme: AfriAppBarTheme.darkAppBarTheme,
    elevatedButtonTheme: AfriElevatedButtonTheme.darkElevatedButtonTheme,
  );
}
