import 'package:flutter/material.dart';
import '../utils/constantes.dart';
import '../models/post_model.dart';
import 'package:caja_tic/screens/webview.dart';
import 'package:caja_tic/api/api_post.dart';
import 'list_builder.dart';

const URL = "$URL_BASE$URL_NOVEDADES";

class Novedades extends StatefulWidget{
  @override
  _NovedadesState createState() => _NovedadesState();

}

class _NovedadesState extends State<Novedades>{
  Api api;

  @override
  void initState() {
    api = new Api();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Novedades', style: TextStyle(color: Colors.white),),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          child: FutureBuilder(
              future: api.getPost(URL),
              builder: (context,snapshot){
                if(snapshot.data == null){
                  return Center(child: CircularProgressIndicator());
                }else{
                 return MyList(snapshot: snapshot);
                }
              }
          ),
        )
    );
  }

}
