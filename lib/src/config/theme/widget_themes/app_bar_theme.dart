import '../../../global_export.dart';

class AfriAppBarTheme{
  const AfriAppBarTheme._();

  static AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: AfriColors.white,
    titleTextStyle: TextStyle(
      color: AfriColors.hex1B1B1B,
      fontSize: AfriFontSizes.size16,
      fontWeight: AfriFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),
  );


  static AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: AfriColors.black,
    titleTextStyle: TextStyle(
      color: AfriColors.white,
      fontSize: AfriFontSizes.size16,
      fontWeight: AfriFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
