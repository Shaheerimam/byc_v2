import 'dart:io';

import 'package:byc_v2/Home_page/pages.dart';
import 'package:byc_v2/pages/newhome.dart';
import 'package:byc_v2/pages/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'BYC', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
    enableVibration: true,
    enableLights: true,
    showBadge: true,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  // a();
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD2j-EE1UqHFjRWzUYVwcgGVcZkwTz1SWw",
            appId: "1:494321785836:web:a51f2be32be49e77067ec9",
            messagingSenderId: "494321785836",
            projectId: "byc-2021",
            storageBucket: 'gs://byc-2021.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }

  if (kIsWeb != true) {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // User? user = FirebaseAuth.instance.currentUser;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'BYC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // ignore: prefer_const_constructors
      home: user != null
          ? newhome(
              direct: false,
              nameban: '',
              post: '',
              taka: 0.0,
            )
          // controller(
          //     direct: true,
          //     nameban: '',
          //     post: '',
          //     taka: 0.0,
          //   )
          : signin(),
      // home: otpstate(password: "password", ID: 'ID'),
    );
  }
}
