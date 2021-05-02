<<<<<<< HEAD
import 'package:flutter/material.dart';

class LoginCarroceiro extends StatelessWidget {
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        //color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              //child: transfere a imagem do login aqui,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Text(
                "CADASTRO",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Nome",
                labelStyle: TextStyle(
                  //color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "CPF",
                labelStyle: TextStyle(
                  //color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Telefone",
                labelStyle: TextStyle(
                  // color: Colors.black38,
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
                  //color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),

            /*Container(
              height: 40,
              // ignore: deprecated_member_use
              child: FlatButton(
                child: Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),*/
          ],
        ),
      ),
    );
  }

  
}
=======
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
>>>>>>> 7358b8f9af9985c71aed8f4e6b279163f2bd6881
