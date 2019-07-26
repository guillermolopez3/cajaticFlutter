import 'package:cached_network_image/cached_network_image.dart';
import 'package:caja_tic/models/post_model.dart';
import 'package:caja_tic/ui/screens/detalle_web.dart';
import 'package:caja_tic/ui/screens/webview.dart';
import 'package:caja_tic/ui/widget/pdf_view.dart';
import 'package:caja_tic/utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/*
 * DISEÑO DEL CARD DE CADA ITEM DE LA LISTA
 */

// ignore: must_be_immutable
class ItemListPost extends StatelessWidget {
  Data data;

  ItemListPost({Key key, this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  child: CachedNetworkImage(
                    imageUrl: "$URL_IMG${data.image}",
                    height: 150.0,
                    fit: BoxFit.fill,
                    placeholder: (context,url)=>Container(
                      height: 150,
                      color: Colors.grey[300],
                    ),
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
            _cardTap(context);
          }),
    );
  }

  void _cardTap(BuildContext context){
    switch(data.idTipoActivity){
      case 1: //general
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetalleWeb(data))); //una pag web comun
        return;
      case 2: //video
        _launchURL(data.link);
        return;
      case 3: //audio
        return;
      case 4: //pdf
        //Navigator.push( context, MaterialPageRoute(builder: (context) => MyWebView(data)));
        Navigator.push( context, MaterialPageRoute(builder: (context) => PdfView(data.link)));
        return;
      case 5: //general
        return;
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
