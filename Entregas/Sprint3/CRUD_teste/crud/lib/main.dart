import 'package:flutter/material.dart';

import 'sql_helper.dart';

void main() {
  runApp(const MyApp());
}

Map<String, Type> userAttributes = {
  'id': int,
  'nome': String,
  'email': String,
  'senha': String,
};

Map<String, Type> accountAttributes = {
  'id': int,
  'userId': int,
  'accountNumber': String,
  'balance': double,
};

Map<String, Type> cardAttributes = {
  'id': int,
  'accountId': int,
  'bankName': String,
  'isInternational': int,
};

Map<String, Type> transactionAttributes = {
  'id': int,
  'value': double,
  'description': String,
  'timestamp': int,
  'method': String,
  'accountId': int,
  'cardId': int,
};

class Table {
  final String name;
  final Map<String, Type> attributes;

  Table(this.name, this.attributes);

  List<String> getFormattedAttributes() {
    return attributes.keys.toList();
  }
}



List<Table> tables = [
  Table('users', {
    'id': int,
    'nome': String,
    'email': String,
    'senha': String,
  }),
  Table('accounts', {
    'id': int,
    'userId': int,
    'accountNumber': String,
    'balance': double,
  }),
  Table('cards', {
    'id': int,
    'accountId': int,
    'bankName': String,
    'isInternational': int,
  }),
  Table('transactions', {
    'id': int,
    'value': double,
    'description': String,
    'timestamp': int,
    'method': String,
    'accountId': int,
    'cardId': int,
  }),

  // Adicione mais tabelas conforme necessário
];


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'SQLITE',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> _accountOptions = [];
  Table _selectedTableForm = tables[0]; // Defina a tabela inicialmente selecionada
  List<String> _tableOptions = ['users', 'accounts','cards','transactions'];
  String _selectedTable = 'users';
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;

  Map<String, TextEditingController> _controllers = {};
  // This function is used to fetch all data from the database
  void _refreshJournals(String tableName) async {
    final data = await SQLHelper.getItems(tableName);
    List<Map<String, dynamic>> updatedData = [];

    if (tableName == 'accounts') {
      data.forEach((journal) {
        Map<String, dynamic> updatedJournal = Map.from(journal);
        updatedJournal['userId'] = updatedJournal['userId'].toString();
        updatedData.add(updatedJournal);
      });
    }
    else if (tableName == 'cards') {
      data.forEach((journal) {
        Map<String, dynamic> updatedJournal = Map.from(journal);
        updatedJournal['accountId'] = updatedJournal['accountId'].toString();
        updatedData.add(updatedJournal);
      });
    }
    else if (tableName == 'transactions') {
      data.forEach((journal) {
        Map<String, dynamic> updatedJournal = Map.from(journal);
        updatedJournal['accountId'] = updatedJournal['accountId'].toString();
        updatedData.add(updatedJournal);
      });
    }





    else {
      updatedData = List.from(data);
    }

    setState(() {
      _journals = updatedData;
      _isLoading = false;
    });
  }



  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _refreshJournals(_selectedTable);
  }

  void _initializeControllers() {
    _controllers = {};

    _selectedTableForm.attributes.keys.forEach((attribute) {
      _controllers[attribute] = TextEditingController(text: '');
    });

    // Inicialize o controller para o atributo 'isInternational' como false
  }








  void _resetControllers() {
    _controllers.values.forEach((controller) {
      controller.text = '';
    });
  }


  void _onTableChanged(String newTable) {
    setState(() {
      _selectedTable = newTable;
      _selectedTableForm = tables.firstWhere((table) => table.name == newTable);
      _initializeControllers();
      _isLoading = true;
    });
    _refreshJournals(_selectedTable);
  }



  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm() {
    _resetControllers();
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ..._selectedTableForm.getFormattedAttributes().map((attribute) {
              if (_selectedTableForm.name == 'users' &&
                  attribute != 'nome' &&
                  attribute != 'email' &&
                  attribute != 'senha') {
                return const SizedBox.shrink();
              }
              if (_selectedTableForm.name == 'accounts' &&
                  attribute != 'userId' &&
                  attribute != 'accountNumber' &&
                  attribute != 'balance') {
                return const SizedBox.shrink();
              }
              if (_selectedTableForm.name == 'cards' &&
                  attribute != 'accountId' &&
                  attribute != 'bankName' &&
                  attribute != 'isInternational') {
                return const SizedBox.shrink();
              }

              if (_selectedTableForm.name == 'transactions' &&
                  attribute != 'value' &&
                  attribute != 'description' &&
                  attribute != 'accountId' &&
                  attribute != 'cardId'
              ) {

                return const SizedBox.shrink();
              }


              return TextField(
                controller: _controllers[attribute],
                decoration: InputDecoration(hintText: attribute),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> attributes = {};
                _selectedTableForm.attributes.keys.forEach((attribute) {
                  if (attribute != 'id') {

                      attributes[attribute] = _controllers[attribute]!.text;

                  }
                });


                await _addItem(_selectedTableForm.name, attributes);
                Navigator.of(context).pop();
              },
              child: Text('Create New'),
            )
          ],
        ),
      ),
    );
  }


// Insert a new journal to the database
  Future<void> _addItem(String tableName, Map<String, dynamic> attributes) async {
    if(tableName == 'transactions'){
      if(attributes['cardId']!='0'){
        attributes['method'] = 'cartão';
      } else{
        attributes['method'] = 'transferencia';
      }
    }
    await SQLHelper.createItem(tableName, attributes);
    _refreshJournals(_selectedTable);
  }



  // Update an existing journal
  Future<void> _updateItem(int id, String tableName, Map<String, dynamic> attributes) async {
    await SQLHelper.updateItem(tableName, id, attributes);
    _refreshJournals(_selectedTable);
  }

  // Delete an item
  void _deleteItem(int id, String tableName) async {
    await SQLHelper.deleteItem(tableName, id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted an item!'),
    ));
    _refreshJournals(_selectedTable);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQL'),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: Text('usuarios'),
                    onTap: ()=> _onTableChanged('users'),
                 ),
                PopupMenuItem(
                  child: Text('contas'),
                  onTap: ()=> _onTableChanged('accounts'),
                ),
                PopupMenuItem(
                  child: Text('cartoes'),
                  onTap: ()=> _onTableChanged('cards'),
                ),
                PopupMenuItem(
                  child: Text('transações'),
                  onTap: ()=> _onTableChanged('transactions'),
                ),
              ],
          ),
        ],
      ),

      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _journals.length,
        itemBuilder: (context, index) {
          final journal = _journals[index];
          String title = '';
          String subtitle = '';

          if (_selectedTable == 'users') {
            title = journal['nome'];
            subtitle = 'e-mail: ${journal['email']}\nid: ${journal['id']}';
          } else if (_selectedTable == 'accounts') {
            title = 'userId: ${journal['userId']}';

          subtitle = 'Saldo: ${journal['balance']}\naccId: ${journal['id']}';
          } else if (_selectedTable == 'cards') {
            title = 'accountID: ${journal['accountId']}';

            subtitle = 'Banco: ${journal['bankName']}\nInternacional: ${journal['isInternational']}';
          }
          else if (_selectedTable == 'transactions') {
            title = '- ${journal['value']}';

            subtitle = 'Método: ${journal['method']}\nDescrição: ${journal['description']}\ncardId: ${journal['cardId']}';
          }




          return Card(
            color: Colors.orange[200],
            margin: const EdgeInsets.all(15),
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showForm(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _deleteItem(journal['id'], _selectedTable),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(),
      ),
    );
  }
}