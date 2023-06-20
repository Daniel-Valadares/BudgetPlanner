import 'dart:ffi';

class User {
  late int _id;
  late String _nome;
  late String _email;

  // Constructor
  User(int id, String nome, String email) {
    this._id = id;
    this._nome = nome;
    this._email = email;
  }

  // Getters
  int getId() {
    return _id;
  }

  String getNome() {
    return _nome;
  }

  String getEmail() {
    return _email;
  }

  // Setters
  void setId(int id) {
    _id = id;
  }

  void setNome(String nome) {
    _nome = nome;
  }

  void setEmail(String email) {
    _email = email;
  }
}
