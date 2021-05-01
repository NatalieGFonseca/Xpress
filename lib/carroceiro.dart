import 'package:flutter/material.dart';

class LoginCarroceiro extends StatelessWidget {
  get onPressed => null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.black,
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

  widgetButton(){
    return RaisedButton(
     padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: onPressed,
                    child: new Text("Add"),);
  }
  
}
