This is a simple Flutter app that receives push notifications from Firebase Cloud Messaging (FCM). Notifications are sent from a PHP backend using Google’s service account credentials.

<h2>Requirements:</h2>

- PHP 8+

- Composer

- Flutter SDK installed

- Android device (for testing)

<h2>Steps to Run:</h2>

- Open the PHP folder and run php -S localhost:8000 to start the server.

- Use the Flutter app (flutter run) on an Android device.

- Replace the device token shown on the android screen inside the PHP script with your actual token (from Flutter logs).

- Call the PHP script (http://localhost:8000/send_notification.php
) → it triggers a push notification to the phone.
