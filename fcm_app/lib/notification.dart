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
  }

  void _initializeFCM() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      setState(() {
        token = token;
      });
      print('FCM Token: $token');

      FirebaseMessaging.onMessage.listen((message) {
        print("Foreground message: ${message.notification?.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("New notification: ${message.notification?.title}"),
          ),
        );
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print("Notification opened: ${message.notification?.title}");
      });

      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
        print('Token refreshed: $newToken');
        setState(() {
          token = newToken;
        });
      });
    } catch (e) {
      print('FCM Setup Error: $e');
    }
    String? token = await _firebaseMessaging.getToken();
    setState(() {
      token = token;
    });
    print('FCM Token: $token');

    FirebaseMessaging.onMessage.listen((message) {
      print("Foreground message: ${message.notification?.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("New notification: ${message.notification?.title}"),
        ),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Notification opened: ${message.notification?.title}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FCM App")),
      body: Center(
        child: Text("This is to get push notifications from corePHP POST api"),
      ),
    );
  }
}
