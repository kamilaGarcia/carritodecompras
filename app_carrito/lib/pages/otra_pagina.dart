import 'package:flutter/material.dart';   //aca se crearia otra pagina de la app

class OtraPagina extends StatefulWidget {
  @override
  _OtraPaginaState createState() => _OtraPaginaState();
}

class _OtraPaginaState extends State<OtraPagina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( //Implementa la estructura de disposición visual básica del diseño de materiales.(regresa el body)
      body: Center(
        child: Text(
          'OtraPagina',
          style: TextStyle(fontSize: 15.0), //estilo del texto
        ),
      ),
    );
  }
}