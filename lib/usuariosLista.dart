import 'package:flutter/material.dart';
import 'package:xpress/database/Usuario.dart';
import 'package:xpress/database/app_database.dart';
import 'package:xpress/tela_usuario.dart';

class UsuarioLista extends StatefulWidget {
  @override
  _UsuarioListaState createState() => _UsuarioListaState();
}

class _UsuarioListaState extends State<UsuarioLista> {
  final Banco _dao = Banco();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuários'),
      ),
      body: FutureBuilder<List<Usuario>>(
        // ignore: deprecated_member_use
        initialData: List(),
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading')
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Usuario> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Usuario contact = contacts[index];
                  return ContactItem(contact);
                },
                itemCount: contacts.length,
              );
              break;
          }
          return Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => TelaUsuario(),
                ),
              )
              .then(
                (value) => setState(() {}),
              );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final Usuario contact;

  ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.email,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          contact.senha.toString(),
          semanticsLabel: contact.telefone.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
