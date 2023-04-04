import 'package:budget_planner/widgets/bottom_form.dart';
import 'package:flutter/material.dart';
import 'package:budget_planner/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
    );
  }
}
