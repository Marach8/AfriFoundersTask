import 'package:shimmer/shimmer.dart';
import '../global_export.dart';

class AfriShimmer extends StatelessWidget {
  const AfriShimmer({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.baseColor,
    this.highlightColor,
    this.margin,
  });

  final double? height, width, radius;
  final EdgeInsetsGeometry? margin;
  final Color? highlightColor, baseColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AfriColors.white.withValues(alpha: 0.7),
      highlightColor: highlightColor ?? AfriColors.hex9A9A9A,
      child: AfriContainer(
        margin: margin,
        height: height ?? 150, radius: radius ?? 10,
        color: baseColor ?? AfriColors.hexBCBCBC,
        width: width ?? context.getScreenWidth,
      ),
    );
  }
}
