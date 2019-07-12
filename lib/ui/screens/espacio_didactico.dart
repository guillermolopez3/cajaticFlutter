import 'package:flutter/material.dart';
import '../../utils/constantes.dart';
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
          _bottomNavItem('assets/img/ic_inicial.png','assets/img/ic_inicial_selec.png' ,'Inicial'),
          _bottomNavItem('assets/img/ic_primaria.png','assets/img/ic_primaria_selec.png', 'Primaria'),
          _bottomNavItem('assets/img/ic_secundario.png','assets/img/ic_secundario_selec.png', 'Secundaria'),
          _bottomNavItem('assets/img/ic_superior.png','assets/img/ic_superior_selec.png' ,'Superior'),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility),
              title: Text('Especial')
          )
        ],
        currentIndex: _selectedIndex,
        fixedColor: color_primario,
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

  BottomNavigationBarItem _bottomNavItem(String img,String img_active, String title) =>
      BottomNavigationBarItem(
          icon: Image.asset(img, height: 24.0, width: 24.0,),
          activeIcon: Image.asset(img_active,height: 24.0,width: 24.0,),
          title: Text(title,)
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

