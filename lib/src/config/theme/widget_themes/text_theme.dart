import '../../../global_export.dart';

class AfriTextTheme{
  const AfriTextTheme._();

  static TextTheme lightTextTheme = TextTheme( 
    headlineMedium: TextStyle(
      color: AfriColors.hex1B1B1B,
      fontSize: AfriFontSizes.size20,
      fontWeight: AfriFontWeights.w700,
      overflow: TextOverflow.ellipsis,
    ),


    titleSmall: TextStyle(
      color: AfriColors.hex1B1B1B,
      fontSize: AfriFontSizes.size16,
      fontWeight: AfriFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),

    
    bodySmall: TextStyle(
      color: AfriColors.hex1B1B1B,
      fontSize: AfriFontSizes.size14,
      fontWeight: AfriFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),
    
    labelMedium: TextStyle(
      color: AfriColors.hex1B1B1B,
      fontSize: AfriFontSizes.size12,
      fontWeight: AfriFontWeights.w400,
      overflow: TextOverflow.ellipsis,
    ),
  );



  static TextTheme darkTextTheme = TextTheme( 

    headlineMedium: TextStyle(
      color: AfriColors.white,
      fontSize: AfriFontSizes.size20,
      fontWeight: AfriFontWeights.w700,
      overflow: TextOverflow.ellipsis,
    ),

    titleSmall: TextStyle(
      color: AfriColors.white,
      fontSize: AfriFontSizes.size16,
      fontWeight: AfriFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),

    bodySmall: TextStyle(
      color: AfriColors.white,
      fontSize: AfriFontSizes.size14,
      fontWeight: AfriFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),

    labelMedium: TextStyle(
      color: AfriColors.white,
      fontSize: AfriFontSizes.size10,
      fontWeight: AfriFontWeights.w400,
      overflow: TextOverflow.ellipsis,
    ),
  );
}