import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class LocalNotificationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static String? pendingPayload;

  static void onTap(NotificationResponse notification) {
    final String? payload = notification.payload;

    if (payload != null &&
        LocalNotificationService.navigatorKey.currentState != null) {
      // لو الـ Navigator جاهز
      LocalNotificationService.navigatorKey.currentState!.pushNamed(
        '/notification_details',
        arguments: payload,
      );
    } else {
      // Navigator مش جاهز → خزّن payload مؤقتًا
      pendingPayload = payload;
    }
  }


  static Future init() async {
    // إعدادات التشغيل
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );

    // تهيئة الإشعارات
    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse:
          onTap, // dy ell hi7sl lma a click 3l notification
      onDidReceiveBackgroundNotificationResponse:
          onTap, // dy lma aft7 notfication w elbrnmag m2fool
    );

    // ⬇️ اطلب إذن الـ Notifications للـ Android 13+ باستخدام permission_handler
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }

    // ⬇️ اطلب إذن للإشعارات على iOS
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }
//repeated
  static void showRepeatedNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "repeated_channel",
        "Repeated Notification",
        channelDescription: "This channel is for repeated notifications",
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      'Repeated Notification',
      'Hello, this is a test repeated notification!',
      RepeatInterval.everyMinute,
      details,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }
//basic
  static void showBasicNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        sound: RawResourceAndroidNotificationSound('sound.mp3'.split('.').first),// دي بتعمل ساوند نتوفيكشن مخصصه
        "basic_channel",
        "Basic Notification",
        channelDescription: "This channel is for basic notifications",
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Basic Notification',
      'Hello, this is a test notification!',
      details,
      payload: "Hello from notfication"
    );
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
//scuduled
  static void showSchudaleNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "scudauld_channel",
        "scuduled Notification",
        channelDescription: "This channel is for scudald notifications",
        importance: Importance.high,
        priority: Priority.high,
      ),
    );
  


    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      "scuduled Notification",
      'body',
      tz.TZDateTime.now(tz.local,).add(Duration(seconds: 10)),
      details,
      payload: 'Hello EveryBody',

      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
