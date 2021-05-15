import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  get Adicionar => null;
  get Entrar => null;

  @override
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
              // autofocus: true,
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
              // autofocus: true,
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
            SizedBox(
              height: 20,
            ),
            widgetButton(),
            cadastra()
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
        color: Colors.blue[400],
        onPressed: Entrar,
        child: new Text("Entrar"));
  }

  cadastra() {
    // ignore: deprecated_member_use
    return RaisedButton(
        padding: const EdgeInsets.all(8.0),
        textColor: Colors.black,
        color: Colors.blue[400],
        onPressed: Adicionar,
        child: new Text("Cadastrar"));
  }
}
