import 'package:budget_planner/screens/home.dart';
import 'package:budget_planner/screens/login_screen.dart';
import 'package:budget_planner/screens/profile_screen.dart';
import 'package:budget_planner/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: {
        '/login': (context) =>  LoginScreen(),
        '/signin': (context) => const signinScreen(),
        '/home': (context) => const Home(),
      },/* const Home() */
    );
  }
}
