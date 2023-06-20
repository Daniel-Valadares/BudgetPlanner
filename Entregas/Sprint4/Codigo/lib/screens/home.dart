import 'package:budget_planner/widgets/circular_chart_container.dart';
import 'package:flutter/material.dart';
import 'package:budget_planner/widgets/bottom_form.dart';

import '../widgets/bottom_navigation.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0x44000000),
          foregroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Budget Planner",
          ),
        ),
        body: Container(),
        bottomNavigationBar: BottomNavigationWidget(),
      ),
    );
  }
}


