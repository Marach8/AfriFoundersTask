import '../global_export.dart';

class AfriLoadingIndicator extends StatelessWidget {
  final Color? color;
  final double size;
  const AfriLoadingIndicator({
    super.key,
    this.color,
    this.size = 25
  });

  @override
  Widget build(context) {
    return SizedBox(
      height: size, width: size,
      child: CircularProgressIndicator(
        color: color ?? Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: (color ?? Theme.of(context)
          .scaffoldBackgroundColor).withValues(alpha: 0.5),
        strokeWidth: 3,
      ),
    );
  }
}
