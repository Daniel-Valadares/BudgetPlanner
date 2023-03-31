import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
        appBar: new AppBar(
          title: new Text("Budget Planner"),

        ),
    );
  }
}

/*
class FirstScreen extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Multi Page Application"),
        ),
        body: RaisedButton(
        child: Text('Launch screen'),
    onPressed: () {
    // Code for Navigation to the second screen.
    ),
    );
    }
  }
*/