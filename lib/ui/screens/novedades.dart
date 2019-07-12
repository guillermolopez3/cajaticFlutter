import 'package:flutter/material.dart';
import '../../utils/constantes.dart';
import '../../models/post_model.dart';
import 'package:caja_tic/ui/screens/webview.dart';
import 'package:caja_tic/api/api_post.dart';
import 'list_builder.dart';
import '../widget/data_error.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widget/shimmer_efect.dart';

class Novedades extends StatefulWidget{
  @override
  _NovedadesState createState() => _NovedadesState();

}

class _NovedadesState extends State<Novedades>{
  Api api;
  int _pagina_act = 0;

  String _url = '$URL_BASE$URL_NOVEDADES';

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
          child: _paginacion(),
        )
    );
  }

  Widget _future(){
    return FutureBuilder(
        future: api.getPost(_url),
        builder: (context,snapshot) {

          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:{
              if(snapshot.hasError)
                return DataError(onPressed: (){
                  setState(() {

                  });
                },);
              else
                return MyList(snapshot: snapshot);
            }
          }
        }
    );
  }

  Widget _paginacion(){
    return PagewiseListView<Data>(
      pageSize: CANTIDAD_PAGINAS,
      itemBuilder: this._listItem,
      pageFuture: (pagIndex){
        _pagina_act = pagIndex;
        String pagina = '&page=${pagIndex +1}';
        return api.getPost('$_url$pagina');
      },
      showRetry: true,
      retryBuilder: (constext,callback){
        if(_pagina_act == 0){
          return Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: DataError(onPressed: callback),
            ),
          );
        }
        else{
          return RaisedButton(
            child: Text('Rintentar'),
        color: color_primario,
        textColor: Colors.white,
        onPressed: () => callback());}
      },
      loadingBuilder:(context){
        return _pagina_act==0 ? ShimmerEfx() : CircularProgressIndicator();
      },
      //noItemsFoundBuilder:(context)=> Text('noItemsFound'),
      //errorBuilder: (context,ob) =>  Text('error builder ${ob}') ,
    );
  }

  //todo hacer el widget CacheImage un widget separado y ver de ponerle una img placeholder q no sea el circleindicator
  Widget _listItem(BuildContext context,Data data,_) => Card(
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
          //_definirRuta(data, context);
        }),
  );

}
