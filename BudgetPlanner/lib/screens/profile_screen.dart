import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xff0052c7), Color(0xff425fff)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://source.unsplash.com/random/?person"),
                ),
                SizedBox(height: 10),
                Text(
                  "Nome do Usuário",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "usuario@email.com.br",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            ...List.generate(
              customListTiles.length,
              (index) {
                final tile = customListTiles[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: ListTile(
                      leading: Icon(tile.icon),
                      title: Text(tile.title),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomListTile {
  final IconData icon;
  final String title;

  CustomListTile({
    required this.icon,
    required this.title,
  });
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    icon: Icons.insights,
    title: "Atividade Recente",
  ),
  CustomListTile(
    title: "Gráficos",
    icon: CupertinoIcons.chart_bar_circle,
  ),
  CustomListTile(
    title: "Preferências de Gastos",
    icon: CupertinoIcons.money_dollar,
  ),
  CustomListTile(
    title: "Estatistica por Cartões",
    icon: CupertinoIcons.creditcard,
  ),
  CustomListTile(
    title: "Estatistica por Banco",
    icon: Icons.account_balance,
  ),
  CustomListTile(
    title: "Baixar Dados de Usuário",
    icon: CupertinoIcons.arrow_down_circle,
  ),
];
