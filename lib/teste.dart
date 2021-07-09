import 'package:flutter/material.dart';
import 'package:xpress/usuariosLista.dart';
import 'database/Usuario.dart';
import 'database/app_database.dart';

class Teste extends StatefulWidget {
  @override
  _TesteForm createState() => _TesteForm();
}

class _TesteForm extends State<Teste> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senha = TextEditingController();
  final Banco _dao = Banco();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full name',
              ),
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _cpfController,
                decoration: InputDecoration(
                  labelText: 'CPF',
                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _telefoneController,
                decoration: InputDecoration(
                  labelText: 'Account number',
                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _senha,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  child: Text('Create'),
                  onPressed: () {
                    final String name = _nameController.text;
                    final int cpf = int.tryParse(_cpfController.text);
                    final int telefone = int.tryParse(_telefoneController.text);
                    final String email = _emailController.text;
                    final String senha = _senha.text;
                    final Usuario novo =
                        Usuario(0, name, cpf, telefone, email, senha);
                    _dao.save(novo).then((id) => Navigator.pop(context));
                    Navigator.push(
                      context, //AQUI VAI A CLASSE DA PAGINA ONDE TA SEGUNDA ROTA
                      MaterialPageRoute(builder: (context) => UsuarioLista()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
