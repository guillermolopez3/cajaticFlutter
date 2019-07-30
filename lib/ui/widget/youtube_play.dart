import 'package:caja_tic/models/post_model.dart';
import 'package:caja_tic/utils/constantes.dart';
import 'package:flutter/material.dart';


class MyYoutubePlayer extends StatefulWidget {
  Data data;

  MyYoutubePlayer(this.data);

  @override
  _MyYoutubePlayerState createState() => _MyYoutubePlayerState();
}

class _MyYoutubePlayerState extends State<MyYoutubePlayer> {
  @override
  Widget build(BuildContext context) {
    final url = Uri.encodeFull('$URL_YOUTUBE${widget.data.link}');
    print('link: $url');
    return Scaffold(
      body: Center(),
    );
  }
}
