import 'package:flutter/material.dart';
import '../utils/constantes.dart';
import 'package:caja_tic/api/api_post.dart';
import 'list_builder.dart';


const URL = "${URL_BASE}$URL_APRENDER_CONECTADOS";

class AprenderConectados extends StatefulWidget {
  @override
  _AprenderConectadosState createState() => _AprenderConectadosState();
}

class _AprenderConectadosState extends State<AprenderConectados> {
  String URL;
  Api api;

  @override
  void initState() {
    URL = "$URL_BASE${URL_APRENDER_CONECTADOS}&seccion=";
    api = new Api();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              tabs: [
                Tab(child: Text('PRIMARIA'),),
                Tab(child: Text('SECUNDARIA'),)
              ]
          ),
          title: Text('Aprender Conectados'),
        ),
        body: TabBarView(
            children: [
              _container('${URL}1'),
              _container('${URL}2'),
            ]
        ),
      ),
    );
  }

  Widget _container(String url)=> Container(
    child: FutureBuilder(
        future: api.getPost(url),
        builder: (context,snapshot){
          if(snapshot.data == null){
            return Center(child: CircularProgressIndicator());
          }else{
            return MyList(snapshot: snapshot,);
          }
        }
    ),
  );


}




