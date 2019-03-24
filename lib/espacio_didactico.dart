import 'package:flutter/material.dart';
import 'utils/constantes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/post_model.dart';
import 'dart:async';

class Espacios extends StatefulWidget{
  @override
  _Espacios createState()=> _Espacios();
}

class _Espacios extends State<Espacios>{
  int _selectedIndex = 0;
  String URL;
  Post post;


  @override
  void initState() {
    print('init state');
    URL = "$URL_BASE${URL_ESPACIO_DIDACTICO}level=${_selectedIndex + 2}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Recursos Didácticos', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _container(),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            _bottomNavItem('assets/img/ic_inicial.png', 'Inicial'),
            _bottomNavItem('assets/img/ic_primaria.png', 'Primaria'),
            _bottomNavItem('assets/img/ic_secundario.png', 'Secundaria'),
            _bottomNavItem('assets/img/ic_superior.png', 'Superior'),
            BottomNavigationBarItem(
                icon: Icon(Icons.accessibility, color: Colors.black,),
                title: Text('Especial', style: TextStyle(color: Colors.black))
            )
          ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      URL = "$URL_BASE${URL_ESPACIO_DIDACTICO}level=${_selectedIndex + 2}";
      _container();
    });
  }

  BottomNavigationBarItem _bottomNavItem(String img, String title) => BottomNavigationBarItem(
      icon: Image.asset(img,height: 24.0,width: 24.0,),
      title: Text(title, style: TextStyle(color: Colors.black))
  );

  Widget _container()=> Container(
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
  );

  Future<List<Data>> _getPost() async{
    print(URL);
    var response = await http.get(URL);
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
              child: Image.network("${URL_IMG}${data.image}", height: 150.0, fit: BoxFit.fill,),
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
      //Navigator.push(context, MaterialPageRoute(builder: (context)=> Detail(data)));
    },
  );
}

