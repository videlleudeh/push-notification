import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotification extends StatefulWidget {
  const PushNotification({super.key});

  @override
  State<PushNotification> createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? token = " ";

  @override
  void initState() {
    super.initState();
    _initializeFCM();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print("Permission status: ${settings.authorizationStatus}");
  }

  void _initializeFCM() async {
    try {
      String? _token = await _firebaseMessaging.getToken();
      setState(() {
        token = _token;
      });
      print('FCM Token: $token');

      FirebaseMessaging.onMessage.listen((message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("New notification: ${message.notification?.title}"),
          ),
        );
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print("Notification opened: ${message.notification?.title}");
      });
    } catch (e) {
      print('FCM Setup Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FCM App")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Copy this token and use in your PHP:',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              SelectableText(
                token ?? 'Loading...',
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 30),
              Text(
                'Notifications will show automatically in notification bar!',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
