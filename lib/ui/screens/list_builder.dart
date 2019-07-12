import 'package:caja_tic/ui/screens/detalle_web.dart';
import 'package:flutter/material.dart';
import 'package:caja_tic/models/post_model.dart';
import 'package:caja_tic/utils/constantes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'webview.dart';

//clase para estructurar la lista con los post

class MyList extends StatelessWidget {
  final AsyncSnapshot<List<Data>> snapshot;

  MyList({this.snapshot});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return _listItem(snapshot.data[index], context);
        });
  }

  Widget _listItem(Data data, BuildContext context) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 2.0,
        child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //imagen
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                  ),
                  child: Hero(
                    tag: data.image,
                    child: Image.network(
                      "$URL_IMG${data.image}",
                      height: 150.0,
                      fit: BoxFit.fill,
                      scale: 0.5,
                    ),
                  ),
                ),
                //Titulo
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    data.title,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //subtitulo
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    data.copete,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //linea divisoria
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
                  child: Container(
                    height: 1.0,
                    decoration: BoxDecoration(color: Colors.grey[300]),
                  ),
                ),
                //tags
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data.tags,
                    style: TextStyle(color: color_accent, fontSize: 14.0),
                  ),
                )
              ],
            ),
            onTap: () {
              _definirRuta(data, context);
            }),
      );

  void _definirRuta(Data data, BuildContext context) {
    int tipo_activity = data.idTipoActivity;
    switch (tipo_activity) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetalleWeb(data))); //una pag web comun
        break;
      case 2:
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> MyWebView(data))); //Video
         _launchURL(data.link);
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyWebView(data)));
        break;
    }
  }

   _launchURL(String link) async {
    final url = Uri.encodeFull('$URL_YOUTUBE$link');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
