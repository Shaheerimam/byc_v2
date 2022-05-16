import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

class Messaging {
  static final Client client = Client();

  // from 'https://console.firebase.google.com'
  // --> project settings --> cloud messaging --> "Server key"
  static const String serverKey =
      'AAAAcxff2-w:APA91bFJo39zqN5MNikl3_SyGyGxfeSYjnjYQe6FnSPNmvhExGfeTvx_vFO5_TROIRIHa1gIsxa9qe_BSMJBSOW3IZFJ1hgDBKbAE4cSH1mi1yLDlTqJxvaHZIoVMsyT3gYpxCrL9uhG';

  static Future<Response> sendToAll({
    required String title,
    required String route,
    required String body,
    required String url,
  }) =>
      sendToTopic(
          title: title, body: body, topic: 'member', route: route, url: url);

  static Future<Response> sendToTopic({
    required String title,
    required String body,
    required String route,
    required String topic,
    required String url,
  }) =>
      sendTo(
          title: title,
          body: body,
          fcmToken: '/topics/$topic',
          route: route,
          url: url);

  static Future<Response> sendTo({
    required String title,
    required String route,
    required String body,
    required String fcmToken,
    required String url,
  }) =>
      client.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: json.encode({
          'notification': {
            'body': body,
            'title': title,
            'android_channel_id': "BYC",
            "image": url
          },
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': 'BYC',
            'status': 'done',
            'route': route,
          },
          'to': fcmToken,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );
}
