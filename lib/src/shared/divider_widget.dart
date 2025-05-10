import '../global_export.dart';

class AfriDivider extends StatelessWidget {
  const AfriDivider({
    super.key,
    this.axis = AxisType.horizontal,
    this.height
  });

  final AxisType? axis;
  final double? height;

  @override
  Widget build(context) {
    final isHorizontal = axis == AxisType.horizontal;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.3),
      height: isHorizontal ? 0.5 : height,
      width: isHorizontal ? context.getScreenWidth : 0.5,
      child: const SizedBox.shrink(),
    );
  }
}

enum AxisType {vertical, horizontal}