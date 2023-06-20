
import 'package:flutter/material.dart';
import 'package:budget_planner/models/global.dart';


final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.blueAccent, Colors.lightBlueAccent],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
);

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  void setLimit(double value) {
    setState(() {
      limite = value;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0052c7), Color(0xff425fff)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nome,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Gastos Totais: R\$ $total",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Limite de Gastos: R\$ $limite",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Gasto Restante: R\$ $restante",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Definir Limite de Gastos"),
                          content: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setLimit(double.parse(value));
                            },
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancelar"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Perform any additional validation or logic if needed
                                Navigator.pop(context);
                              },
                              child: Text("Definir"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Definir Limite"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
