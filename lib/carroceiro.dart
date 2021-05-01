import 'package:flutter/material.dart';

class LoginCarroceiro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              //child: transfere a imagem do login aqui,
            ),
            SizedBox(
              height: 20,
            ),
            Text("CADASTRO"),
            Column(
              children: [
                Text("Nome: "),
                Text("CPF: "),
                Text("Telefone: "),
                Text("Email: ")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
