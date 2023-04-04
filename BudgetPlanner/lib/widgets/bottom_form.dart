import 'package:flutter/material.dart';

class BottomForm extends StatefulWidget {
  const BottomForm({super.key});

  @override
  State<BottomForm> createState() => _BottomFormState();
}

class _BottomFormState extends State<BottomForm> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  bool light = true;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Center(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              title: Text("Cadastrar"),
              elevation: 0,
              bottom: TabBar(
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
                  Form(
                    key: _formKey1,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Nome do Banco',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Saldo Inicial',
                              ),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Concluir'),
                            ),
                          ),
                        ]),
                  ),
                  Form(
                    key: _formKey2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Nome do Banco',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Cartão Intenacional',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Tags',
                              ),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Concluir'),
                            ),
                          ),
                        ]),
                  ),
                  Form(
                    key: _formKey3,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Valor',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Método de Pagamento',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Tags',
                              ),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Concluir'),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
      ),
    );
  }
}
