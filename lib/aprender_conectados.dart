import 'package:flutter/material.dart';
import 'utils/constantes.dart';
import 'models/post_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'detalle_web.dart';
import 'webview.dart';
import 'package:url_launcher/url_launcher.dart';


const URL = "${URL_BASE}$URL_APRENDER_CONECTADOS";

class AprenderConectados extends StatefulWidget {
  @override
  _AprenderConectadosState createState() => _AprenderConectadosState();
}

class _AprenderConectadosState extends State<AprenderConectados> {
  int _selectedIndex = 1;
  String URL;
  Post post;

  @override
  void initState() {
    //URL = "$URL_BASE${URL_ESPACIO_DIDACTICO}level=${_selectedIndex}";
    URL = "$URL_BASE${URL_APRENDER_CONECTADOS}&seccion=";
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
              _container(1),
              _container(2),
            ]
        ),
      ),
    );
  }

  Widget _container(int seccion)=> Container(
    child: FutureBuilder(
        future: _getPost(seccion),
        builder: (context,snapshot){
          if(snapshot.data == null){
            return Center(child: CircularProgressIndicator());
          }else{
            print(_lista(snapshot));
            return _lista(snapshot);
          }
        }
    ),
  );

  Future<List<Data>> _getPost(int seccion) async{
    final NURL = '$URL$seccion';
    print(NURL);
    var response = await http.get(NURL);
    var decodeJson = jsonDecode(response.body);
    post = Post.fromJson(decodeJson);
    print(decodeJson);
    return post.data;
  }

  Widget _lista(AsyncSnapshot<List<Data>> snapshot)=> ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index){
        print(snapshot.data[index].title);
        return  _listItem(snapshot.data[index]);
      }
  );


  Widget _listItem(Data data) => InkWell(
    splashColor: Colors.grey[800],
    child: Container(
      height: 310.0,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
              child: Hero(
                tag: data.image,
                child: Image.network("$URL_IMG${data.image}", height: 150.0, fit: BoxFit.fill,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                data.title,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                data.copete,
                style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
              child: Container(
                height: 1.0,
                decoration: BoxDecoration(color: Colors.grey[300]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0),
              child: Text(
                data.tags,
                style: TextStyle(color: color_accent, fontSize: 14.0),
              ),
            )
          ],
        ),
      ),
    ),
    onTap: (){
      //Navigator.push(context, MaterialPageRoute(builder: (context)=> DetalleWeb(data)));
      _definirRuta(data);
    },
  );

  void _definirRuta(Data data){
    int tipo_activity = data.idTipoActivity;
    switch(tipo_activity){
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetalleWeb(data))); //una pag web comun
        break;
      case 2:
      //Navigator.push(context, MaterialPageRoute(builder: (context)=> MyWebView(data))); //Video
        _launchURL(data.link);
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context)=> MyWebView(data)));
        break;
    }
  }

  _launchURL(String link) async {
    final url = Uri.encodeFull('${URL_YOUTUBE}$link');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}




