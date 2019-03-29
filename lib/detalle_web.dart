import 'package:flutter/material.dart';
import 'models/post_model.dart';
import 'utils/constantes.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalleWeb extends StatefulWidget{
  Data data;

  DetalleWeb(this.data);

  @override
  _DetalleWeb createState()=> _DetalleWeb();
}

const mExpandedHeight = 200.0;

class _DetalleWeb extends State<DetalleWeb>{
  ScrollController _scrollController;


  @override
  void initState() {
    _scrollController = ScrollController()
    ..addListener(()=> setState((){}));
  }

  //cuando esta expandido (offset 0.0) no se muestra el titulo, recien cuando se va contrayendo y el ofset es > a 10 aparece el texto
  bool get _showTitle{
    return _scrollController.hasClients && _scrollController.offset >= 10.0;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
              controller: _scrollController ,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: mExpandedHeight,
                    flexibleSpace: FlexibleSpaceBar(
                      title: _showTitle ? Text('${widget.data.title}', style: TextStyle(color: Colors.white), maxLines: 1,overflow: TextOverflow.ellipsis,) : null,
                      background: Hero(
                        tag: widget.data.image,
                        child: Image.network("$URL_IMG${widget.data.image}", height: 150.0, fit: BoxFit.cover,),
                      ),
                    ),
                    floating: true,
                    pinned: true,
                  )
                ];
              },
              body: _cuerpo(widget.data)
          )
      ),
    );
  }

  Widget _cuerpo(Data data) => ListView(
    padding: EdgeInsets.all(12.0),
    children: <Widget>[
      _texto('${data.title}', Theme.of(context).textTheme.headline),
      _texto('${data.tags}', Theme.of(context).textTheme.caption),
      Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Container(height: 1.0, decoration: BoxDecoration(color: Colors.grey[400])),
      ),
      _texto('${data.description}', Theme.of(context).textTheme.body1),
      RaisedButton(
        color: color_primario,
        child: Text('Ver mas sobre el recurso',style: TextStyle(color: Colors.white),),
          onPressed: (){
            //Navigator.push(context, MaterialPageRoute(builder: (context)=> MyWebView(data)));
            _launchURL();
          }
          )
    ],
  );

  Widget _texto(String texto, TextStyle txtStyle) => Padding(
    padding: texto==null ? EdgeInsets.only(bottom: 1.0) : EdgeInsets.only(bottom: 10.0),
    child: Text(
        texto,
        style: txtStyle
    )
  );

  _launchURL() async {
    final url = Uri.encodeFull(widget.data.link);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}