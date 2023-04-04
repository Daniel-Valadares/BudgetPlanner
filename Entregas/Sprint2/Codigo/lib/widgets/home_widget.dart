import 'package:budget_planner/widgets/bottom_form.dart';
import 'package:budget_planner/widgets/circular_chart_container.dart';
import 'package:budget_planner/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.blueAccent, Colors.lightBlueAccent],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
);

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff0052c7), Color(0xff425fff)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: CircleAvatar(
                                          radius: 60,
                                          backgroundImage: NetworkImage(
                                              'https://source.unsplash.com/random/?person'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text("Nome do Usuário",
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      )
                                    ]),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Gastos Totais: ",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..shader = linearGradient,
                                      ),
                                    ),
                                    Text(
                                      "R\$ 1.730,50",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..shader = linearGradient,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ChartContainer(
                          title: 'R\$ 3070,00 restantes',
                          color: Colors.transparent,
                          chart: PieChartContent(),
                        ),
                        TableCalendar(
                          firstDay: DateTime.utc(1900, 10, 16),
                          lastDay: DateTime.utc(3000, 3, 14),
                          focusedDay: DateTime.now(),
                          headerStyle: HeaderStyle(
                            titleTextStyle: TextStyle(color: Colors.white),
                            formatButtonTextStyle: TextStyle(color: Colors.white),
                          ),
                          calendarStyle: CalendarStyle(
                            defaultTextStyle: TextStyle(color: Colors.white),
                            weekNumberTextStyle: TextStyle(color: Colors.white),
                            outsideTextStyle: TextStyle(color: Colors.white),
                            rangeEndTextStyle: TextStyle(color: Colors.white),
                            rangeStartTextStyle: TextStyle(color: Colors.white),
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(color: Colors.white),
                            weekendStyle: TextStyle(color: Colors.white),
                          ),
                          weekNumbersVisible: false,

                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      ),
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
    );
  }
}