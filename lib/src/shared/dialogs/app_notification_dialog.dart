import 'package:another_flushbar/flushbar.dart';

import '../../global_export.dart';

Future<dynamic> showAppNotification({
  required BuildContext context,
  required Widget? icon,
  required String text,
  int? duration,
  Color? bgColor
}) async {
  return Flushbar(
    backgroundColor: AfriColors.transparent,
    flushbarPosition: FlushbarPosition.TOP,
    duration: Duration(seconds: duration ?? 5),
    messageText: Center(
      child: AfriContainer(
        radius: 10, color: bgColor ?? AfriColors.red,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(icon != null) icon,
            if(icon != null) const SizedBox(width: 10),
            Flexible(
              child: Text(
                text, maxLines: 2,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AfriColors.white
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ).show(context);
}



// dynamic notifyBar(BuildContext context, String type, String message){
//   return Flushbar<dynamic>(
//     flushbarPosition: FlushbarPosition.TOP,
//     reverseAnimationCurve: Curves.decelerate,
//     forwardAnimationCurve: Curves.elasticOut,
//     backgroundColor: Colors.transparent,
//     duration: const Duration(seconds: 3),
//     //leftBarIndicatorColor: getColor(type),
//     //borderRadius: BorderRadius.circular(12),
//     //margin: const EdgeInsets.all(6.0),
//     messageText: Center(
//       child: SwervContainer(
//         radius: 10,
//         padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
//         color: getColor(type),
//         child: Text(
//           message, maxLines: 2,
//           style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//             fontSize: 12,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     ),
//   ).show(context);
// }