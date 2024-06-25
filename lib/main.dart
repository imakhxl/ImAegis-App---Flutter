import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/aes_screen.dart';
import 'screens/end_screen.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/first': (context) => const ImaegisApp(),
        '/second': (context) => const EndPage(),
      },
    );
  }
}
