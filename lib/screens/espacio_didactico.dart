import 'package:flutter/material.dart';
import '../utils/constantes.dart';
import 'list_builder.dart';
import 'package:caja_tic/api/api_post.dart';

class Espacios extends StatefulWidget{
  @override
  _Espacios createState()=> _Espacios();
}

class _Espacios extends State<Espacios> {
  int _selectedIndex = 0;
  String URL;
  Api api;


  @override
  void initState() {
    URL = "$URL_BASE${URL_ESPACIO_DIDACTICO}level=${_selectedIndex + 2}";
    api = new Api();
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      URL = "$URL_BASE${URL_ESPACIO_DIDACTICO}level=${_selectedIndex + 2}";
      _container();
    });
  }

  BottomNavigationBarItem _bottomNavItem(String img, String title) =>
      BottomNavigationBarItem(
          icon: Image.asset(img, height: 24.0, width: 24.0,),
          title: Text(title, style: TextStyle(color: Colors.black))
      );

  Widget _container() =>
      Container(
        child: FutureBuilder(
            future: api.getPost(URL),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                return MyList(snapshot: snapshot);
              }
            }
        ),
      );
}

