import 'package:cached_network_image/cached_network_image.dart';
import 'package:caja_tic/models/post_model.dart';
import 'package:caja_tic/ui/widget/data_error.dart';
import 'package:caja_tic/ui/widget/item_list_post.dart';
import 'package:caja_tic/ui/widget/shimmer_efect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import '../../utils/constantes.dart';
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
  int _pagina_act = 0;

  @override
  void initState() {
    URL = "$URL_BASE${URL_APRENDER_CONECTADOS}&seccion=";
    api = new Api();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              tabs: [
                Tab(child: Text('INICIAL'),),
                Tab(child: Text('PRIMARIA'),),
                Tab(child: Text('SECUNDARIA'),)
              ]
          ),
          title: Text('Aprender Conectados'),
        ),
        body: TabBarView(
            children: [
              _paginacion('${URL}8'),
              _paginacion('${URL}1'),
              _paginacion('${URL}2'),
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

  Widget _paginacion(String url){
    return PagewiseListView<Data>(
      pageSize: CANTIDAD_PAGINAS,
      itemBuilder: (context,data,_) => ItemListPost(data: data,),
      pageFuture: (pagIndex){
        _pagina_act = pagIndex;
        String pagina = '&page=${pagIndex +1}';
        return api.getPost('$url$pagina');
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

}




