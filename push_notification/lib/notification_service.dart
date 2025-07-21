import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await _messaging.requestPermission();
    await _initializeLocalNotifications();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_handleForegroundNotification);
  }

  static Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const settings = InitializationSettings(android: androidSettings);
    await _localNotificationsPlugin.initialize(settings);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    _showLocalNotification(
      title: message.notification?.title ?? 'Background',
      body: message.notification?.body ?? 'Message',
    );
  }

  static void _handleForegroundNotification(RemoteMessage message) {
    _showLocalNotification(
      title: message.notification?.title ?? 'Foreground',
      body: message.notification?.body ?? 'Message',
    );
  }

  static void showSimulatedNotification(String title, String body) {
    _showLocalNotification(title: title, body: body);
  }

  static void _showLocalNotification({
    required String title,
    required String body,
  }) {
    _localNotificationsPlugin.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'General Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}
