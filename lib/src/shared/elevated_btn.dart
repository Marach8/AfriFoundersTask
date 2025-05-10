import '../global_export.dart';

class AfriElevatedBtn extends StatelessWidget {
  const AfriElevatedBtn({
    super.key,
    required this.btnTitle,
    required this.onPressed,
    this.height,
    this.bgColor,
    this.fgColor,
    this.showLoading
  });

  final String btnTitle;
  final void Function()? onPressed;
  final double? height;
  final Color? bgColor, fgColor;
  final bool? showLoading;

  @override
  Widget build(context) {
    return AbsorbPointer(
      absorbing: showLoading ?? false,
      child: ElevatedButton(
        onPressed:  onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: fgColor,
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          fixedSize: Size(context.getScreenWidth, height ?? 45)
        ),
        child: (showLoading ?? false) ? AfriLoadingIndicator() :  Text(btnTitle),
      ),
    );
  }
}

