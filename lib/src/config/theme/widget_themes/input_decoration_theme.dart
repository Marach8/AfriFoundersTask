import '../../../global_export.dart';

class AfriInputDecorationTheme{
  const AfriInputDecorationTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 1,
    isDense: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    fillColor: AfriColors.transparent,
    filled: true,
    hintStyle: TextStyle(
      color: AfriColors.black.withValues(alpha: 0.5),
      fontSize: AfriFontSizes.size14,
      fontWeight: AfriFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),
    errorStyle: TextStyle(
      color: AfriColors.red.withValues(alpha: 0.6),
      fontSize: AfriFontSizes.size12,
      fontWeight: AfriFontWeights.w400,
      overflow: TextOverflow.ellipsis,
    ),

    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        color: AfriColors.hex1B1B1B
      )
    ),

    disabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        color: AfriColors.hex1B1B1B.withValues(alpha: 0.2)
      )
    ),

    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        color: AfriColors.red.withValues(alpha: 0.6)
      )
    ),

    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.8,
        color: AfriColors.red.withValues(alpha: 0.8)
      )
    ),

    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.8,
        color: AfriColors.hex1B1B1B
      )
    ),
  );



  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 1,
    isDense: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    fillColor: AfriColors.transparent,
    filled: true,
    hintStyle: TextStyle(
      color: AfriColors.white.withValues(alpha: 0.5),
      fontSize: AfriFontSizes.size14,
      fontWeight: AfriFontWeights.w500,
      overflow: TextOverflow.ellipsis,
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        color: AfriColors.white.withValues(alpha: 0.5)
      )
    ),

    errorStyle: TextStyle(
      color: AfriColors.red.withValues(alpha: 0.6),
      fontSize: AfriFontSizes.size12,
      fontWeight: AfriFontWeights.w400,
      overflow: TextOverflow.ellipsis,
    ),


    disabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        color: AfriColors.white.withValues(alpha: 0.2)
      )
    ),

    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.5,
        color: AfriColors.red.withValues(alpha: 0.6)
      )
    ),

    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.8,
        color: AfriColors.red.withValues(alpha: 0.8)
      )
    ),

    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0.8,
        color: AfriColors.white
      )
    ),
  );
}