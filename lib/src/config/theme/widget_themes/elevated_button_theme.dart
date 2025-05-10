
import '../../../global_export.dart';

class AfriElevatedButtonTheme{
  const AfriElevatedButtonTheme._();

  static ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AfriColors.white,
      backgroundColor: AfriColors.hex1B1B1B,
      disabledForegroundColor: AfriColors.white.withValues(alpha: 0.3),
      disabledBackgroundColor: AfriColors.transparent,
      textStyle: TextStyle(
        fontFamily: AfriStrings.AXIFORMA,
        fontSize: AfriFontSizes.size18,
        fontWeight: AfriFontWeights.w600
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))
    )
  );

  static ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AfriColors.hex1B1B1B,
      backgroundColor: AfriColors.white,
      disabledForegroundColor: AfriColors.hex1B1B1B.withValues(alpha: 0.3),
      disabledBackgroundColor: AfriColors.transparent,
      textStyle: TextStyle(
        fontFamily: AfriStrings.AXIFORMA,
        fontSize: AfriFontSizes.size18,
        fontWeight: AfriFontWeights.w600
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))
    )
  );
}