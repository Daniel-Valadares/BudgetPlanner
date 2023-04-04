import 'package:budget_planner/widgets/bottom_form.dart';
import 'package:flutter/material.dart';

class BankListWidgets extends StatelessWidget {
  const BankListWidgets({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff425fff),
            elevation: 0,
              flexibleSpace: TabBar(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                unselectedLabelColor: Colors.white70,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.lightBlue, Colors.lightBlueAccent]),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.cyanAccent),
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Contas"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Cartões"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Transações"),
                    ),
                  ),
                ]),
          ),
          body: TabBarView(
              children: [
                Text("Lista 1"),
                Text("Lista 2"),
                Text("Lista 3")
              ]),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigoAccent,
            foregroundColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const SizedBox(
                    height: 800,
                    child: BottomForm(),
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class Tab1Widget extends StatelessWidget {
  const Tab1Widget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [],
          ),
        )),
      ),
    );
  }
}

class Tab2Widget extends StatelessWidget {
  const Tab2Widget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [],
          ),
        )),
      ),
    );
  }
}

class Tab3Widget extends StatelessWidget {
  const Tab3Widget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [],
          ),
        )),
      ),
    );
  }
}
