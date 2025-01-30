import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'pages/login.dart';
import 'pages/registration.dart';
import 'pages/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banger Labz',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegistrationPage(),
        '/home': (context) => Dashboard(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
