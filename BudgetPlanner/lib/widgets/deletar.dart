import 'package:budget_planner/models/global.dart';
import 'package:flutter/material.dart';
import 'package:budget_planner/DAO/user_DAO.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

final TextEditingController _senhaController = TextEditingController();

class _DeleteAccountState extends State<DeleteAccount> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Deletar Conta',style: TextStyle(color: Colors.black)),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: Column(
          children: [
            const Text('Você tem certeza que deseja deletar sua conta', style: TextStyle(
                fontSize: 16, letterSpacing: 2.2, color: Colors.redAccent)),
            buildInputForm('Senha', true),

            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () async {
                      if(await UserDAO.getUserByEmailBool(email, _senhaController.text)){
                        UserDAO.deleteUser(id);
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                },
                child: const Text("Deletar",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
              ),
            )
          ],
        ),

      ),
    );
  }
  Padding buildInputForm(String hint, bool pass) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: _senhaController,
          obscureText: pass ? _isObscure : false,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: pass
                ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: _isObscure
                    ? const Icon(
                  Icons.visibility_off,
                )
                    : const Icon(
                  Icons.visibility,
                ))
                : null,
          ),
        ));
  }
}