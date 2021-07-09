import 'package:flutter/material.dart';
import 'package:xpress/database/Motorista.dart';
import 'package:xpress/database/app_database_motorista.dart';
import 'package:xpress/motoristasLista.dart';

class TelaMotorista extends StatefulWidget {
  @override
  State<TelaMotorista> createState() {
    return Motorista();
  }
}

class Motorista extends State<TelaMotorista> {
  get onPressed => null;

  TextEditingController _nome = TextEditingController();
  TextEditingController _cpf = TextEditingController();
  TextEditingController _telefone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _rg = TextEditingController();
  TextEditingController _placa = TextEditingController();
  TextEditingController _modelo = TextEditingController();
  TextEditingController _cor = TextEditingController();
  TextEditingController _senha = TextEditingController();
  TextEditingController _cnh = TextEditingController();
  final BancoMotorista _dao = BancoMotorista();

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
              controller: _email,
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
              autofocus: true,
              keyboardType: TextInputType.visiblePassword,
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
            TextFormField(
              controller: _cpf,
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
              controller: _rg,
              autofocus: true,
              keyboardType: TextInputType.number,
              obscureText: false,
              decoration: InputDecoration(
                labelText: "RG",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
                controller: _cnh,
                autofocus: true,
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: "CNH",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                style: TextStyle(fontSize: 20),
                validator: (_cnh) {
                  if (_cnh.length != 9) {
                    _cnh = '';
                    return 'Digite novamente';
                  }
                }),
            TextFormField(
              controller: _telefone,
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
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Text(
                "Informações do veículo",
                style: TextStyle(fontSize: 15, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ),
            TextFormField(
              controller: _placa,
              autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: InputDecoration(
                labelText: "Placa",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              controller: _modelo,
              autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: InputDecoration(
                labelText: "Modelo",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              controller: _cor,
              autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: InputDecoration(
                labelText: "Cor",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 10,
            ),
            widgetButton()
          ],
        ),
      ),
    );
  }

  widgetButton() {
    // ignore: deprecated_member_use
    return RaisedButton(
        padding: const EdgeInsets.all(8.0),
        textColor: Colors.black,
        color: Colors.blue,
        onPressed: () {
          if ((valida_cpf(_cpf) == true) &&
              (valida_telefone(_telefone) == true) &&
              (valida_vazio(_nome, _cpf, _telefone, _email, _rg, _placa,
                      _modelo, _cor, _senha, _cnh) ==
                  true) &&
              (valida_senha(_senha))) {
            final String name = _nome.text;
            final int cpf = int.tryParse(_cpf.text);
            final int telefone = int.tryParse(_telefone.text);
            final String email = _email.text;
            final int rg = int.tryParse(_rg.text);
            final String placa = _placa.text;
            final String modelo = _modelo.text;
            final String cor = _cor.text;
            final String senha = _senha.text;
            final int cnh = int.tryParse(_cnh.text);
            final Motoristas novo = Motoristas(0, name, email, cpf, rg,
                telefone, placa, modelo, cor, senha, cnh);
            _dao.save(novo).then((id) => Navigator.pop(context));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MotoristaLista()),
            );
          }
        },
        child: new Text("Cadastrar"));
  }

  valida_vazio(nome, cpf, telefone, email, rg, placa, modelo, cor, senha, cnh) {
    if ((nome.toString().isNotEmpty) &&
        (cpf.toString().isNotEmpty) &&
        (telefone.toString().isNotEmpty) &&
        (email.toString().isNotEmpty) &&
        (rg.toString().isNotEmpty) &&
        (placa.toString().isNotEmpty) &&
        (modelo.toString().isNotEmpty) &&
        (cor.toString().isNotEmpty) &&
        (senha.toString().isNotEmpty) &&
        (cnh.toString().isNotEmpty)) {
      return true;
    } else {
      return false;
    }
  }

  // ignore: non_constant_identifier_names
  valida_cpf(cpf) {
    if (cpf.toString().length != 9) {
      return false;
    } else {
      return true;
    }
  }

  // ignore: non_constant_identifier_names
  valida_telefone(telefone) {
    if (telefone.toString().length != 11) {
      return false;
    } else {
      return true;
    }
  }

  // ignore: non_constant_identifier_names
  valida_senha(senha) {
    if ((senha.contains("^[a-Z]")) && (senha.toString().length > 8)) {
      return true;
    } else {
      return false;
    }
  }
}
