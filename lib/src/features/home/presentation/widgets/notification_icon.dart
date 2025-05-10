import 'package:contact_alarm/src/global_export.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;

class NotificationIcon extends StatefulWidget {
  const NotificationIcon({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  State<NotificationIcon> createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(widget.contact.hasReminder){
          NotificationService.cancelReminder(
            widget.contact, onCancel: () => setState(() => widget.contact.hasReminder = false),
          );
        }
        else{
          NotificationService.scheduleReminder(
            widget.contact, onExecute: () => setState(() => widget.contact.hasReminder = false),
          );
          setState(() => widget.contact.hasReminder = true);
        }
      },
      splashColor: Theme.of(context).textTheme.headlineMedium?.color?.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Icon(
            CupertinoIcons.bell,
            color: (widget.contact.hasReminder) ? AfriColors.successColor : null,
          ),
          if(widget.contact.hasReminder) Positioned(
            right: 5, top: 0,
            child: AfriContainer(
              height: 10, width: 10, radius: 5,
              color: AfriColors.successColor,
            ),
          )
        ],
      )
    );
  }
}