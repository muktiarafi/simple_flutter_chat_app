import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final fcm = FirebaseMessaging();
    fcm.configure(
      onLaunch: (msg) {
        return;
      },
      onMessage: (msg) {
        return;
      },
      onResume: (msg) {
        return;
      },
    );
    fcm.subscribeToTopic('chat');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/loading.gif',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
