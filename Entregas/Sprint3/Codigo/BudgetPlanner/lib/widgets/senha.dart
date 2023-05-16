import 'package:budget_planner/models/global.dart';
import 'package:flutter/material.dart';
import 'package:budget_planner/DAO/user_DAO.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

final TextEditingController _senhaController = TextEditingController();
final TextEditingController _newsenhaController = TextEditingController();
final TextEditingController _newsenhaController1 = TextEditingController();

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Alterar senha',style: TextStyle(color: Colors.black)),
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
            buildInputForm('Senha atual', true),
            buildInputForm1('Nova senha', true),
            buildInputForm2('Confirme a nova senha', true),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () async {
                  if(await UserDAO.getUserByEmailBool(email, _senhaController.text)){
                    if(_newsenhaController1.text == _newsenhaController.text){
                      await UserDAO.updateUser(id, nome, email, _newsenhaController.text);
                    }
                  }
                },
                child: const Text("Salvar",
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

  Padding buildInputForm1(String hint, bool pass) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: _newsenhaController,
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

  Padding buildInputForm2(String hint, bool pass) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: _newsenhaController1,
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