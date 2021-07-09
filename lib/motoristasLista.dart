import 'package:flutter/material.dart';
import 'package:xpress/database/Motorista.dart';
import 'package:xpress/database/app_database_motorista.dart';
import 'package:xpress/tela_motorista.dart';

import 'teste.dart';

class MotoristaLista extends StatefulWidget {
  @override
  _MotoristaListaState createState() => _MotoristaListaState();
}

class _MotoristaListaState extends State<MotoristaLista> {
  final BancoMotorista _dao = BancoMotorista();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Motoristas'),
      ),
      body: FutureBuilder<List<Motoristas>>(
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
              final List<Motoristas> motoristass = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Motoristas motoristas = motoristass[index];
                  return _DriversItem(motoristas);
                },
                itemCount: motoristass.length,
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
                  builder: (context) => TelaMotorista(),
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

class _DriversItem extends StatelessWidget {
  final Motoristas motoristas;

  _DriversItem(this.motoristas);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          motoristas.email,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          motoristas.senha.toString(),
          semanticsLabel: motoristas.placa.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
