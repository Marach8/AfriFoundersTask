import 'dart:async';
import 'package:contact_alarm/src/features/home/data/models/contact_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../global_export.dart' show VoidCallback;

class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _notificationPlugin
    = FlutterLocalNotificationsPlugin();

  static final Map<String, (Timer, Contact)> _scheduledReminders = {};

  static Future<void> initializeNotification() async {
    const AndroidInitializationSettings androidInitSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitSettings = DarwinInitializationSettings();

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _notificationPlugin.initialize(initSettings);

    await _notificationPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  static void scheduleReminder(
    Contact contact,
    {VoidCallback? onExecute}
  ) {
    final timer = Timer(
      const Duration(seconds: 60), 
      () {
      _executeReminder(contact);

      //Auto cleanup.
      cancelReminder(contact, onCancel: onExecute);
    });

    _scheduledReminders.putIfAbsent(contact.id,() => (timer, contact));
  }


  static Future<void> _executeReminder(Contact contact) async {
    final notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _notificationPlugin.show(
      notificationId,
      '',
      'Reminder: Call ${contact.name} at ${contact.phoneNumber}',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  static void cancelReminder(
    Contact contact,
    {VoidCallback? onCancel}
  ){
    _scheduledReminders[contact.id]?.$1.cancel();
    _scheduledReminders.remove(contact.id);
    if(onCancel != null){
      onCancel.call();
    }
  }
}





// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();
//   factory NotificationService() => _instance;
//   NotificationService._internal();

//   final FlutterLocalNotificationsPlugin _notifications = 
//       FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     const AndroidInitializationSettings androidSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
    
//     const DarwinInitializationSettings iOSSettings =
//         DarwinInitializationSettings();

//     await _notifications.initialize(
//       const InitializationSettings(
//         android: androidSettings,
//         iOS: iOSSettings,
//       ),
//     );

//     await _createNotificationChannel();
//   }

//   Future<void> _createNotificationChannel() async {
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'reminder_channel', // Same as your channel ID
//       'Reminder Notifications',
//       importance: Importance.max, // <-- Critical change
//       showBadge: true,
//       pla
//       sound: RawResourceAndroidNotificationSound('notification'),
//     );

//     await _notifications
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }

//   Future<void> showNotification({
//     required String title,
//     required String body,
//     required int id,
//   }) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'reminder_channel',
//       'Reminder Notifications',
//       channelDescription: 'Channel for reminder notifications',
//       importance: Importance.max, // <-- Must match channel
//       priority: Priority.high,
//       showWhen: true,
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('notification'),
//       enableVibration: true,
//       visibility: NotificationVisibility.public, // <-- Critical
//     );

//     const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
//       presentSound: true,
//       presentBadge: true,
//       presentAlert: true,
//     );

//     await _notifications.show(
//       id,
//       title,
//       body,
//       const NotificationDetails(
//         android: androidDetails,
//         iOS: iOSDetails,
//       ),
//     );
//   }
// }