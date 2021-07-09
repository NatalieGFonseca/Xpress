import 'package:flutter/material.dart';
import 'package:xpress/tela_usuario.dart';
import 'package:xpress/tela_motorista.dart';

import 'map_page.dart';

class TelaPagamento extends StatefulWidget {
  @override
  State<TelaPagamento> createState() {
    return Pagamento();
  }
}

class Pagamento extends State<TelaPagamento> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Xpress')),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Nome do Usuario"),
              accountEmail: Text("nome@email.com"),
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://w7.pngwing.com/pngs/831/216/png-transparent-computer-icons-youtube-youtube-logo-profile-avatar-area.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
            ListTile(
                title: Text("Home"),
                trailing: Icon(Icons.home),
                onTap: () {
                  Navigator.push(
                    context, //AQUI VAI PARA A TELA DO USUÁRIO
                    MaterialPageRoute(builder: (context) => TelaUsuario()),
                  );
                }),
            ListTile(
                title: Text("Perfil"),
                subtitle: Text("Alteração de dados"),
                trailing: Icon(Icons.account_circle),
                onTap: () {
                  Navigator.push(
                    context, //AQUI VAI PARA A TELA DO MOTORISTA
                    MaterialPageRoute(builder: (context) => TelaMotorista()),
                  );
                }),
            ListTile(
                title: Text("Pagamentos"),
                trailing: Icon(Icons.payment),
                onTap: () {
                  Navigator.push(
                    context, //AQUI VAI PARA A TELA DE PAGAMENTO
                    MaterialPageRoute(builder: (context) => TelaPagamento()),
                  );
                  debugPrint('Vai para tela de pagamento ');
                }),
            ListTile(
                title: Text("Histórico"),
                trailing: Icon(Icons.history),
                onTap: () {
                  /*Navigator.push(
                          context,  AQUI VAI A CLASSE DA PAGINA ONDE TA SEGUNDA ROTA
                          MaterialPageRoute(builder: (context) => SegundaRota()),
                        );*/
                  debugPrint('Vai pra tela de historico de corrida');
                }),
            ListTile(
                title: Text("Localização"),
                trailing: Icon(Icons.my_location),
                onTap: () {
                  Navigator.push(
                    context, //AQUI VAI A CLASSE DA PAGINA ONDE TA SEGUNDA ROTA
                    MaterialPageRoute(builder: (context) => Mapa()),
                  );
                }),
          ],
        ),
      ),
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
                "Valor: ",
                style: TextStyle(fontSize: 20, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              child: Text(
                "Pagamentos",
                style: TextStyle(fontSize: 20, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),

            //BOTÕES PARA PAGAMENTOS
// ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {},
              padding: const EdgeInsets.all(1.0),
              textColor: Colors.black,
              child: ListTile(
                leading: Icon(
                  Icons.money,
                  color: Colors.green,
                  size: 40,
                ),
                title: Text('Dinheiro'),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {},
              padding: const EdgeInsets.all(1.0),
              textColor: Colors.black,
              child: ListTile(
                leading: Icon(
                  Icons.payment,
                  color: Colors.blue,
                  size: 40,
                ),
                title: Text('Cartão'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {},
              padding: const EdgeInsets.all(1.0),
              textColor: Colors.black,
              child: ListTile(
                leading: Icon(
                  Icons.payments,
                  color: Colors.blue,
                  size: 40,
                ),
                title: Text('Adicionar novo cartão'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
