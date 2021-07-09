import 'package:flutter/material.dart';
import 'package:xpress/login.dart';
import 'database/app_database.dart';
import 'database/Usuario.dart';

class TelaUsuario extends StatefulWidget {
  @override
  State<TelaUsuario> createState() {
    return UsuarioTela();
  }
}

class UsuarioTela extends State<TelaUsuario> {
  get onPressed => null;

  TextEditingController _nome = TextEditingController();
  TextEditingController _cpf = TextEditingController();
  TextEditingController _telefone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _senha = TextEditingController();
  final Banco _dao = Banco();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Xpress')),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset('imagens/Xpress Logo.png'),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Text(
                "CADASTRO",
                style: TextStyle(fontSize: 20, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _nome,
              onSaved: (val) => _nome = val as TextEditingController,
              autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              controller: _cpf,
              onSaved: (val) => _cpf = val as TextEditingController,
              autofocus: true,
              keyboardType: TextInputType.number,
              obscureText: false,
              decoration: InputDecoration(
                labelText: "CPF",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              controller: _telefone,
              onSaved: (val) => _telefone = val as TextEditingController,
              autofocus: true,
              keyboardType: TextInputType.number,
              obscureText: false,
              decoration: InputDecoration(
                labelText: "Telefone",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              controller: _email,
              onSaved: (val) => _email = val as TextEditingController,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              controller: _senha,
              onSaved: (val) => _senha = val as TextEditingController,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),

            //BOTÃO PARA ADICIONAR DADOS DO USUÁRIO
            // ignore: deprecated_member_use
            RaisedButton(
              child: Text('Cadastrar'),
              onPressed: () {
                final String name = _nome.text;
                final int cpf = int.tryParse(_cpf.text);
                final int telefone = int.tryParse(_telefone.text);
                final String email = _email.text;
                final String senha = _senha.text;
                final Usuario novo =
                    Usuario(0, name, cpf, telefone, email, senha);
                _dao.save(novo).then((id) => Navigator.pop(context));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaLogin()),
                );
              },
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.black,
              color: Colors.blue[400],
            ),
          ],
        ),
      ),
    );
  }
}
