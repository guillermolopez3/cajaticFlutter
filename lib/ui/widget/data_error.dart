import 'package:flutter/material.dart';
import 'package:caja_tic/utils/constantes.dart';

class DataError extends StatelessWidget {

  final VoidCallback onPressed;

  DataError({Key key, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/img/no_data.png', width: 250, height: 250),
          RaisedButton(
            color: color_primario,
            textColor: Colors.white,
            onPressed: onPressed,
            child: Text('REINTENTAR'),
          )
        ],
      ),
    );
  }
}
