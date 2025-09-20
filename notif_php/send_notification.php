<?php
//  echo 'Hello! This server is working init.'
require 'vendor/autoload.php';
use Google\Client;

$serviceAccountKey = "C:/notif_php/fcm-app-key.json";

$projectID = "fcm-app-d7d7d";

$deviceToken = "cXulSLqOHoWUU4U-nea0sd:APA91bEKUxwxkLs-rRHJbm2GrF4rX2wCJC-GTLgh8ToOlbPqZfvBfztChcloCNckV_4IppeltCQGj80SJ6uqTyWz-pYf1HYsow65XQ96B-v0-THmyVAzrrU";

$message = [
    "token" => $deviceToken,
    'notification' => [
        'title' => "This is from pHp",
        'body' => "You have a new notification",
    ]
    ];

function getAccessToken($serviceAccountKey) {
    // Load Google client
    $client = new Client();
    $client->setAuthConfig($serviceAccountKey);
    $client->addScope("https://www.googleapis.com/auth/firebase.messaging");
    $client->useApplicationDefaultCredentials();
    // Get an access token
    $token = $client->fetchAccessTokenWithAssertion();
    return $token['access_token'];
}

function sendMessage($accessToken, $projectID, $message) {
    // Send the HTTP request to FCM
    $url = "https://fcm.googleapis.com/v1/projects/$projectID/messages:send";

    $headers = [
    'Authorization: Bearer ' . $accessToken,
    'Content-Type: application/json',
    ];
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode(['message' => $message]));

    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    
    $response = curl_exec($ch);

    if ($response === false) {
    throw new Exception('cURL error: ' . curl_error($ch));
    }
    curl_close($ch);
    return json_decode($response, true);
}

try {
   $accessToken = getAccessToken($serviceAccountKey);
   $response = sendMessage($accessToken, $projectID, $message);
   echo 'Notification sent successfully! ';
} catch (Exception $e) {
   echo 'Error: ' . $e->getMessage();
}

?>