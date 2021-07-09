import 'package:flutter/material.dart';
import 'package:xpress/motoristasLista.dart';
import 'package:xpress/tela_motorista.dart';
import 'package:xpress/tela_usuario.dart';
import 'package:xpress/usuariosLista.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    context, //AQUI VAI A CLASSE DA PAGINA ONDE TA SEGUNDA ROTA
                    MaterialPageRoute(builder: (context) => TelaUsuario()),
                  );
                }),
            ListTile(
                title: Text("Perfil"),
                subtitle: Text("Alteração de dados"),
                trailing: Icon(Icons.account_circle),
                onTap: () {
                  Navigator.push(
                    context, //AQUI VAI A CLASSE DA PAGINA ONDE TA SEGUNDA ROTA
                    MaterialPageRoute(builder: (context) => TelaMotorista()),
                  );
                }),
            ListTile(
                title: Text("Pagamentos"),
                trailing: Icon(Icons.payment),
                onTap: () {
                  /*Navigator.push(
                          context,  AQUI VAI A CLASSE DA PAGINA ONDE TA SEGUNDA ROTA
                          MaterialPageRoute(builder: (context) => SegundaRota()),
                        );*/
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
                title: Text("Registro motorista"),
                trailing: Icon(Icons.drive_eta_rounded),
                onTap: () {
                  Navigator.push(
                    context, //AQUI VAI A CLASSE DA PAGINA ONDE TA SEGUNDA ROTA
                    MaterialPageRoute(builder: (context) => MotoristaLista()),
                  );
                }),
            ListTile(
                title: Text("Registro usuario"),
                trailing: Icon(Icons.person),
                onTap: () {
                  Navigator.push(
                    context, //AQUI VAI A CLASSE DA PAGINA ONDE TA SEGUNDA ROTA
                    MaterialPageRoute(builder: (context) => UsuarioLista()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
