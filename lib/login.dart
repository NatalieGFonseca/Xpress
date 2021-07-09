import 'dart:core';

import 'package:flutter/material.dart';
import 'package:xpress/map_page.dart';
import 'package:xpress/tela_motorista.dart';
import 'package:xpress/tela_usuario.dart';

class TelaLogin extends StatefulWidget {
  @override
  State<TelaLogin> createState() {
    return Login();
  }
}

class Login extends State<TelaLogin> {
  BuildContext get context => null;
  TextEditingController _usuario = TextEditingController();
  TextEditingController _senha = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Text(
                "Bem-vindo(a)",
                style: TextStyle(fontSize: 40, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset('imagens/Xpress Logo.png'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _usuario,
              autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
              textInputAction: TextInputAction.next,
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
            SizedBox(
              height: 40,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
                onPressed: () {},
                padding: const EdgeInsets.all(1.0),
                textColor: Colors.black,
                color: Colors.blue[400],
                child: ListTile(
                    title: Text(
                      "Entrar",
                      textAlign: TextAlign.center,
                    ),
                    contentPadding: const EdgeInsets.all(1.0),
                    onTap: () async {
                      /*Banco banco = Banco();
                      bool testeSenha =
                          banco.verificaSenha(_senha.text) as bool;
                      bool testeUsuario =
                          banco.verificaUsuario(_usuario.text) as bool;

                       if (testeUsuario = true) {
                        if (testeSenha = true) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapView()));
                        } else {
                          return 'Senha inválida, digite novamente';
                        }
                      } else {
                        return 'Por favor, verifique o usuário e senha digitados';
                      }*/

                      if (_usuario.text == 'admin@admin.com') {
                        if (_senha.text == '123') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapView()));
                        }
                      }
                    })),
            SizedBox(
              height: 20,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
                onPressed: () {},
                padding: const EdgeInsets.all(1.0),
                textColor: Colors.black,
                color: Colors.blue[400],
                child: ListTile(
                    title: Text(
                      "Novo Usuario",
                      textAlign: TextAlign.center,
                    ),
                    contentPadding: const EdgeInsets.all(1.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelaUsuario()),
                      );
                    })),
            SizedBox(
              height: 20,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
                onPressed: () {},
                padding: const EdgeInsets.all(1.0),
                textColor: Colors.black,
                color: Colors.blue[400],
                child: ListTile(
                    title: Text(
                      "Novo Motorista",
                      textAlign: TextAlign.center,
                    ),
                    contentPadding: const EdgeInsets.all(1.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaMotorista()),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
