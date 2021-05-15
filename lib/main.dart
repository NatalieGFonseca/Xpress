import 'package:flutter/material.dart';
import 'package:xpress/tela_usuario.dart';
//import 'package:xpress/tela_motorista.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpress',
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(primarySwatch: Colors.blue[800]),
      home: Usuario(),
    );
  }
}
