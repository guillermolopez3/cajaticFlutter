import 'dart:async';
import 'package:caja_tic/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {

  Future<List<Data>> getPost(String url) async{
    print(url);
    Post post = new Post();
    var response = await http.get(url);
    var decodeJson = jsonDecode(response.body);
    post = Post.fromJson(decodeJson);
    return post.data;
  }
}
