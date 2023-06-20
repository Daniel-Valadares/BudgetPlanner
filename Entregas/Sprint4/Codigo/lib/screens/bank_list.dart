import 'package:flutter/material.dart';
import 'package:budget_planner/models/global.dart';
import 'package:budget_planner/DAO/user_DAO.dart';
List<Map<String, dynamic>> _accounts = [];
List<Map<String, dynamic>> _cards = [];
List<Map<String, dynamic>> _transactions = [];
class BankListWidgets extends StatefulWidget {
  const BankListWidgets({super.key});

  @override
  State<BankListWidgets> createState() => _BankListWidgets();
}

class _BankListWidgets extends State<BankListWidgets> {

  @override
  void initState() {
    super.initState();
    // Corpo do método initState
  }

  void _updateAccountsList() async {
    final data = await UserDAO.getAccountItems(id);
    List<Map<String, dynamic>> updatedData = [];

    updatedData = List.from(data);

    final data2 = await UserDAO.getCardItems(id);
    List<Map<String, dynamic>> updatedData2 = [];

    updatedData2 = List.from(data2);

    final data3 = await UserDAO.getTransactionItems(id);
    List<Map<String, dynamic>> updatedData3 = [];

    updatedData3 = List.from(data3);

    setState(() {
      _accounts = updatedData;
      _cards = updatedData2;
      _transactions = updatedData3;
    });
  }

  Future<void> _getAccounts() async {
    final accounts = await UserDAO.getAccountItems(id);
    setState(() {
      _accounts = accounts;
    });
  }

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
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff0052c7), Color(0xff425fff)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
            child: Center(
              child: TabBarView(
                  children: [
                    BankCardList(accounts: _accounts, updateAccountsList: _updateAccountsList),
                    CardCardList(cards: _cards),
                    TransactionCardList(transactions: _transactions),
                  ]),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigoAccent,
            foregroundColor: Colors.white,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return BottomForm(
                    updateAccountsList: _updateAccountsList,
                    update: false,
                    Id: 0,
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

class BottomForm extends StatefulWidget {
  final void Function() updateAccountsList;
  final bool update;
  final int Id;
  const BottomForm({Key? key, required this.updateAccountsList, required this.update, required this.Id})
      : super(key: key);

  @override
  State<BottomForm> createState() => _BottomFormState();
}

class _BottomFormState extends State<BottomForm> {
  bool isInternational = false; // Variável para controlar o estado do checkbox
  bool isCartao = false;
  int CartaoValue = 0;
  int internacionalValue = 0; // Variável para armazenar o valor do campo
  int selectedBankId=0; // ID do banco selecionado
  List<Map<String, dynamic>> bankList = []; // Lista de bancos registrados no banco de dados

  Future<void> _refreshJournals() async {
    final data = await UserDAO.getAccountItems(id);
    List<Map<String, dynamic>> updatedData = [];

    updatedData = List.from(data);

    final data2 = await UserDAO.getCardItems(id);
    List<Map<String, dynamic>> updatedData2 = [];

    updatedData2 = List.from(data2);

    final data3 = await UserDAO.getTransactionItems(id);
    List<Map<String, dynamic>> updatedData3 = [];

    updatedData3 = List.from(data3);

    setState(() {
      _accounts = updatedData;
      _cards = updatedData2;
      _transactions = updatedData3;
    });
  }

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();





  bool light = true;

  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getBanks();
  }

  Future<void> _getBanks() async {
    final accounts = await UserDAO.getAccountItems(id);
    setState(() {
      bankList = accounts;
      selectedBankId = bankList[0]['id'];
    });
  }

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
                            controller: _bankNameController,
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
                            controller: _balanceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Saldo Inicial',
                            ),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if(!widget.update){
                                await _addAccount();
                              }else{
                                await _updateAccount(widget.Id);
                              }


                              _refreshJournals();

                              Navigator.of(context).pop();
                            },
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
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                          child: DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Nome do Banco',
                            ),

                            value: selectedBankId,
                            onChanged: (value) {
                              setState(() {
                                selectedBankId = value!;
                              });
                            },
                            items: bankList.map((bank) {
                              final bankId = bank['id'];
                              final bankName = bank['bankName'];
                              return DropdownMenuItem<int>(
                                value: bankId,
                                child: Text(bankName),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                          child: CheckboxListTile(
                            title: Text('Cartão Internacional'),
                            value: isInternational,
                            onChanged: (value) {
                              setState(() {
                                isInternational = value!;
                                internacionalValue = value ? 1 : 0;
                              });
                            },
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if(!widget.update){
                                await _addCard(internacionalValue,selectedBankId);
                              }else{
                                await _updateCard(widget.Id,selectedBankId,internacionalValue);
                              }


                              _refreshJournals();

                              Navigator.of(context).pop();
                            },
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
                            controller: _valueController,
                            keyboardType: TextInputType.number,
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
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Descrição',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                          child: DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Nome do Banco',
                            ),
                            value: selectedBankId,
                            onChanged: (value) {
                              setState(() {
                                selectedBankId = value!;
                              });
                            },
                            items: bankList.map((bank) {
                              final bankId = bank['id'];
                              final bankName = bank['bankName'];
                              return DropdownMenuItem<int>(
                                value: bankId,
                                child: Text(bankName),
                              );
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                          child: CheckboxListTile(
                            title: Text('Via cartão'),
                            value: isCartao,
                            onChanged: (value) {
                              setState(() {
                                isCartao = value!;
                                CartaoValue = value ? 1 : 0;
                              });
                            },
                          ),
                        ),

                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if(!widget.update){
                                await _addTransaction(selectedBankId,CartaoValue);
                              }

                              _refreshJournals();

                              Navigator.of(context).pop();
                            },
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
  Future<void> _addAccount() async {
    await UserDAO.createAccountItem(id, _bankNameController.text, double.parse(_balanceController.text));
    widget.updateAccountsList(); // Chama a função de atualização da lista
  }

  Future<void> _addCard(int isInternational, int bankId) async {
    await UserDAO.createCardItem(id,bankId, isInternational);
    widget.updateAccountsList(); // Chama a função de atualização da lista
  }

  Future<void> _addTransaction(int bankId, int method) async {
    await UserDAO.createTransactionItem(id,double.parse(_valueController.text), _descriptionController.text, bankId, method);
    widget.updateAccountsList(); // Chama a função de atualização da lista
  }

  Future<void> _updateAccount(int Id) async {
    await UserDAO.updateAccountItem(Id,
        _bankNameController.text, double.parse(_balanceController.text));
    final data = await UserDAO.getAccountItems(id);
    List<Map<String, dynamic>> updatedData = [];
    updatedData = List.from(data);
    _accounts = updatedData;
  }

  Future<void> _updateCard(int Id, int bankId, int isInternational) async {
    await UserDAO.updateCardItem(Id,
        bankId, isInternational);
    final data = await UserDAO.getAccountItems(id);
    List<Map<String, dynamic>> updatedData = [];
    updatedData = List.from(data);
    _accounts = updatedData;
  }


}



class BankCardList extends StatelessWidget {
  final List<Map<String, dynamic>> accounts;
  final void Function() updateAccountsList;

  const BankCardList({Key? key, required this.accounts, required this.updateAccountsList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        final account = accounts[index];
        final name = account['bankName'];
        final Saldo = account['balance'];
        final Id = account['id'];


        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album),
                title: Text(name),
                subtitle: Text('Saldo: $Saldo'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Editar'),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return BottomForm(
                            updateAccountsList: updateAccountsList,
                            update: true,
                            Id: Id,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Icon(Icons.delete),
                    onPressed: () async {

                      await  UserDAO.deleteAccountItem(Id);
                      final data = await UserDAO.getAccountItems(id);
                      List<Map<String, dynamic>> updatedData = [];

                      updatedData = List.from(data);
                      _accounts = updatedData;
                      print("oi");
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class CardCardList extends StatelessWidget {
  final List<Map<String, dynamic>> cards;

  const CardCardList({Key? key, required this.cards}) : super(key: key);
  void _updateAccountsList() {
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        final name = card['bankName'];
        final internacional = card['isInternational'];
        final Id = card['id'];
        final String isInternacional;
        if(internacional==0){
          isInternacional = 'Não';
        }else{
          isInternacional = 'Sim';
        }


        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album),
                title: Text(name),
                subtitle: Text('Internacional: $isInternacional'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Editar'),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return BottomForm(
                            updateAccountsList: _updateAccountsList,
                            update: true,
                            Id: Id,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Icon(Icons.delete),
                    onPressed: () async {

                      await  UserDAO.deleteCardItem(Id);
                      final data = await UserDAO.getCardItems(id);
                      List<Map<String, dynamic>> updatedData = [];

                      updatedData = List.from(data);
                      _cards = updatedData;
                      print("oi");
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class TransactionCardList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const TransactionCardList({Key? key, required this.transactions}) : super(key: key);
  void _updateAccountsList() {
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final value = transaction['value'];
        final description = transaction['description'];
        final name = transaction['bankName'];
        final type = transaction['method'];
        final Id = transaction['id'];
        final String isCartao;
        if(type==0){
          isCartao = 'Transferencia';
        }else{
          isCartao = 'Cartão';
        }


        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album),
                title: Text('-$value'),
                subtitle: Text('Banco: $name\nMétodo: $isCartao\nDescrição: $description'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Editar'),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return BottomForm(
                            updateAccountsList: _updateAccountsList,
                            update: true,
                            Id: Id,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Icon(Icons.delete),
                    onPressed: () async {

                      await  UserDAO.deleteTransactionItem(Id);
                      final data = await UserDAO.getTransactionItems(id);
                      List<Map<String, dynamic>> updatedData = [];

                      updatedData = List.from(data);
                      _transactions = updatedData;
                      print("oi");
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        );
      },
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
                children: [
                  ...List.generate(
                    CardBankCards.length,
                        (index) {
                      return Center(
                        child: CardBankCards[index],
                      );
                    },
                  )
                ],
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
                children: [
                  ...List.generate(
                    transactionCards.length,
                        (index) {
                      return Center(
                        child: transactionCards[index],
                      );
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}

List<Card> BankCards = [
  Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.album),
          title: Text('Banco StackHolder'),
          subtitle: Text('Número da Conta: XXXXXXXXX'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: const Text('Editar'),
              onPressed: () {/* ... */},
            ),
            const SizedBox(width: 8),
            TextButton(
              child: const Icon(Icons.delete),
              onPressed: () {/* ... */},
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    ),
  ),
];

List<Card> CardBankCards = [
  Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.album),
          title: Text('Cartão XXX - Banco StackHolder'),
          subtitle: Text('Limite: 1700,00'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: const Text('Editar'),
              onPressed: () {/* ... */},
            ),
            const SizedBox(width: 8),
            TextButton(
              child: const Icon(Icons.delete),
              onPressed: () {/* ... */},
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    ),
  ),


];

List<Card> transactionCards = [
  Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.album),
          title: Text('Transação - Realizada em 17/08/2022'),
          subtitle: Text('Valor: 170,00'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: const Text("Editar"),
              onPressed: () {/* ... */},
            ),
            const SizedBox(width: 8),
            TextButton(
              child: const Icon(Icons.delete),
              onPressed: () {/* ... */},
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    ),
  ),


];



