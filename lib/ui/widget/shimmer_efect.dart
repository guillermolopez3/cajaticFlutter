import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

//Efecto en una lista cuando algo se esta cargando como en facebook/netflix

class ShimmerEfx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _shiList();
  }

  _shiList()=> Column(
    children: <Widget>[
      _shi_prueba(),
      _shi_prueba(),
      _shi_prueba()
    ],
  );
  _shi_prueba() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget>[
                  //imagen
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8),
                  //titulo
                  Padding(
                    padding: const EdgeInsets.only(left:10.0, right: 10.0),
                    child: Container(
                        width: double.infinity,
                        height: 16.0,
                        color: Colors.white,
                      ),
                  ),
                  SizedBox(height: 10,),
                  //linea divisoria
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
                    child: Container(
                      height: 1.0,
                      decoration: BoxDecoration(color: Colors.grey[300]),
                    ),
                  ),
                   SizedBox(height: 10),
                  //tag
                  Padding(
                    padding: const EdgeInsets.only(left:10.0, right: 10.0),
                    child: Container(
                      width: 60,
                      height: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
                ),
              )

      );
}
