import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../models/post_model.dart';
import '../../utils/constantes.dart';
import 'dart:async';

class MyWebView extends StatefulWidget{
  final Data data;

  //escuela vicente forestielli

  MyWebView(this.data);

  @override
  _MyWebView createState() => _MyWebView();

}

class _MyWebView extends State<MyWebView>{
  Completer<WebViewController> _controller = Completer<WebViewController>();
  String URL="";


  @override
  void initState() {
    definirUrl();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SafeArea(
            child: WebView(
              initialUrl: URL,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController wbController){
                _controller.complete(wbController);

              },
              onPageFinished: (String complete){
                print(complete);
              },
            )
        )
    );
  }

  //dependiendo si el pdf esta en el host del minis o es una web es la URL que creo
  void definirUrl(){
    var temp_url = widget.data.link;
    URL = temp_url.startsWith('http')? '$URL_PDF_VIEW$temp_url' : '$URL_PDF_VIEW_MINISTERIO$temp_url';
  }


}