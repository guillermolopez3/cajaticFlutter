import 'package:flutter/material.dart';
import 'novedades.dart';
import 'espacio_didactico.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/img/logo_appbar.png',
              fit: BoxFit.contain,
              height: 32,
            ),
          ],
        ),
      ),
      body: _body
    );
  }

  final _body = GridView.builder(
    padding: EdgeInsets.all(10.0),
    itemCount: 3,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0
    ),
    itemBuilder: (BuildContext context, int index){
      switch(index){
        case 0: return _bodyItem('assets/img/novedades.png',0,context);
        case 1: return _bodyItem('assets/img/espacio_didactico.png',1,context);
        case 2: return _bodyItem('assets/img/aprender_conectados.png',2,context);
      }
    },


  );

  static _bodyItem(String ruta, int indice, context){
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(ruta),
        ),
        onTap: () => _pressItem(indice,context)

      ),
    );
  }

  static _pressItem(int indice,context){
    switch(indice){
      case 0:
        return Navigator.push(context, MaterialPageRoute(builder: (context)=>Novedades()));
      case 1:
        return Navigator.push(context, MaterialPageRoute(builder: (context)=>Espacios()));
    }
  }
}