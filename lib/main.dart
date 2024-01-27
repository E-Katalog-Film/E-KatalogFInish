import 'package:flutter/material.dart';
import 'package:movieproject/authentication/login_page.dart';
import 'package:movieproject/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Katalog Movie',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      initialRoute: '/login', // Set rute awal ke '/login'
      routes: {
        '/login': (context) => const LoginPage(title: 'Login UI'), // Rute untuk LoginPage
        '/home': (context) => HomeScreen(), // Rute untuk HomeScreen
      },
    );
  }
}
