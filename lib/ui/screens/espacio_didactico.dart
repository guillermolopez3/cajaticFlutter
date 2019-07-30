import 'package:cached_network_image/cached_network_image.dart';
import 'package:caja_tic/ui/widget/data_error.dart';
import 'package:caja_tic/ui/widget/shimmer_efect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import '../../utils/constantes.dart';
import 'package:caja_tic/api/api_post.dart';
import '../../models/post_model.dart';

class Espacios extends StatefulWidget {
  @override
  _Espacios createState() => _Espacios();
}

class _Espacios extends State<Espacios> with SingleTickerProviderStateMixin {
  int _currentSeccion = 0; //seccion actual del bottom bar
  TabController _tabController;
  List<Widget> _tab = [
    TabRecursos(2),
    TabRecursos(3),
    TabRecursos(4),
    TabRecursos(5),
    TabRecursos(6),
  ];


  @override
  void initState() {
   _tabController = TabController(length: _tab.length, vsync: this);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text('Recursos Didácticos', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body:TabBarView(
        controller: _tabController,
        children: _tab,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _bottomNavItem('assets/img/ic_inicial.png', 'assets/img/ic_inicial_selec.png', 'Inicial'),
          _bottomNavItem('assets/img/ic_primaria.png','assets/img/ic_primaria_selec.png', 'Primaria'),
          _bottomNavItem('assets/img/ic_secundario.png', 'assets/img/ic_secundario_selec.png', 'Secundaria'),
          _bottomNavItem('assets/img/ic_superior.png', 'assets/img/ic_superior_selec.png', 'Superior'),
          BottomNavigationBarItem( icon: Icon(Icons.accessibility), title: Text('Especial'))
        ],
        currentIndex: _currentSeccion,
        fixedColor: color_primario,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentSeccion = index;
      _tabController.animateTo(_currentSeccion);
    });
  }

  BottomNavigationBarItem _bottomNavItem(String img, String img_active,
      String title) =>
      BottomNavigationBarItem(
          icon: Image.asset(
            img,
            height: 24.0,
            width: 24.0,
          ),
          activeIcon: Image.asset(
            img_active,
            height: 24.0,
            width: 24.0,
          ),
          title: Text(
            title,
          ));

  //segun la seccion en la que este es el level para la url
  int _nivelSeleccionado()
  {
    int id_nivel = 2;
    switch(_currentSeccion){
      case 0:
        id_nivel = 2;
        break;
      case 1:
        id_nivel = 3;
        break;
      case 2:
        id_nivel = 4;
        break;
      case 3:
        id_nivel = 5;
        break;
      case 4:
        id_nivel = 6;
        break;
    }
    return id_nivel;
  }


}

class TabRecursos extends StatefulWidget {
  int level;

  TabRecursos(this.level);

  @override
  _TabRecursos createState() => _TabRecursos();
}

class _TabRecursos extends State<TabRecursos> {

  String _url;
  int _nivel;
  int _currentPage = 0;

  @override
  void initState() {
    _url = '$URL_BASE$URL_RD${widget.level}';
    _nivel = widget.level;
  }

  Api api;
  @override
  Widget build(BuildContext context) {
    api = new Api();
    return Scaffold(
      body: _paginacion(),
    );
  }
  Widget _paginacion() {
    return PagewiseListView<Data>(
      pageSize: CANTIDAD_PAGINAS,
      itemBuilder: this._listItem,
      pageFuture: (pagIndex) {
        _currentPage = pagIndex;
        String pagina = '&page=${pagIndex + 1}';
        return api.getPost('$_url$pagina');
      },
      showRetry: true,
      retryBuilder: (constext, callback) {
        if (_currentPage == 0) {
          return Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: DataError(onPressed: callback),
            ),
          );
        }
        else {
          return RaisedButton(
              child: Text('Rintentar'),
              color: color_primario,
              textColor: Colors.white,
              onPressed: () => callback());
        }
      },
      loadingBuilder: (context) {
        return _currentPage == 0 ? ShimmerEfx() : CircularProgressIndicator();
      },
    );
  }

  //todo hacer el widget CacheImage un widget separado y ver de ponerle una img placeholder q no sea el circleindicator
  Widget _listItem(BuildContext context, Data data, _) =>
      Card(
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
                      placeholder: (context, url) =>
                          Container(
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


