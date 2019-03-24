import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'utils/constantes.dart';
import 'models/post_model.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

const URL = "${URL_BASE}$URL_NOVEDADES";

class Novedades extends StatefulWidget{
  @override
  _NovedadesState createState() => _NovedadesState();

}

class _NovedadesState extends State<Novedades>{
  Post post;


  @override
  void initState() {
    _fetchNovedades();
  }

  void _fetchNovedades() async{
    var response = await http.get(URL);
    var decodeJson = jsonDecode(response.body);
    setState(() {
      post = Post.fromJson(decodeJson);
    });
  }

  Future<List<Data>> _getPost() async{
    var response = await http.get(URL);
    var decodeJson = jsonDecode(response.body);
    post = Post.fromJson(decodeJson);
    return post.data;
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('Novedades', style: TextStyle(color: Colors.white),),
//          iconTheme: IconThemeData(color: Colors.white),
//        ),
//        body: ListView(
//          children: post == null
//            ? <Widget>[Center(child: CircularProgressIndicator(),)]
//           : post.data.map((item)=>Padding(padding: EdgeInsets.only(top: 10.0,bottom: 10.0), child: _listItem(item),)).toList(),
//        )
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Novedades', style: TextStyle(color: Colors.white),),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          child: FutureBuilder(
              future: _getPost(),
              builder: (context,snapshot){
                if(snapshot.data == null){
                  return Center(child: CircularProgressIndicator());
                }else{
                 return _lista(snapshot);
                }
              }
          ),
        )
    );
  }

  Widget _lista(AsyncSnapshot<List<Data>> snapshot)=> ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index){
        return _listItem(snapshot.data[index]);
      }
  );

  Widget _listItem(Data data) => InkWell(
    splashColor: Colors.grey[800],
    child: Container(
      height: 250.0,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150.0,
              child: Image.network("${URL_IMG}${data.image}"),
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
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
              child: Container(
                height: 1.0,
                decoration: BoxDecoration(color: Colors.grey[300]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0),
              child: Text(
                data.tags ?? '',
                style: TextStyle(color: color_accent, fontSize: 14.0),
              ),
            )
          ],
        ),
      ),
    ),
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Detail(data)));
    },
  );

}

class Detail extends StatefulWidget{
  final Data data;

  Detail(this.data);

  @override
  _Detail createState() => _Detail();

}

class _Detail extends State<Detail>{
  Completer<WebViewController> _controller = Completer<WebViewController>();



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: WebView(
          initialUrl: '$URL_PDF_VIEW_MINISTERIO${widget.data.link}',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController wbController){
            _controller.complete(wbController);

          },
          onPageFinished: (String complete){
            print(complete);
          },
        ),
      )
    );
  }

}