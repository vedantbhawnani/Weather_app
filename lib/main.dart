import 'package:flutter/material.dart';

import 'home/ui/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(226, 234, 242, 1),
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            bodySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            labelSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            labelMedium: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            labelLarge: TextStyle(fontSize: 84, fontWeight: FontWeight.bold),
            headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
      darkTheme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white),
          scaffoldBackgroundColor: const Color.fromRGBO(47, 54, 67, 1),
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            bodyMedium: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            bodySmall: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            labelSmall: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            labelMedium: TextStyle(
                fontSize: 54, fontWeight: FontWeight.bold, color: Colors.white),
            labelLarge: TextStyle(
                fontSize: 84, fontWeight: FontWeight.bold, color: Colors.white),
            headlineSmall: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          )),
      home: const HomePage(),
    );
  }
}
