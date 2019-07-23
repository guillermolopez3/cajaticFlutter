import 'package:flutter/material.dart';

const URL_BASE = "https://www.igualdadycalidadcba.gov.ar/CajaTIC/api/";
const URL_YOUTUBE = "https://www.youtube.com/watch?v=";
const URL_NOVEDADES = "getAllNovedadesConFav?ano=2019";
const URL_IMG = "https://www.igualdadycalidadcba.gov.ar/CajaTIC/storage/public/";
//cuando el pdf se guarda en el server del ministerio uso esta url que tiene el viewer
const URL_PDF_VIEW_MINISTERIO = "https://www.igualdadycalidadcba.gov.ar/CajaTIC/js/web/viewer.html?file=$URL_IMG"; //cuando el link del pdf esta alojado en el ministerio
const URL_PDF_VIEW = "https://www.igualdadycalidadcba.gov.ar/CajaTIC/js/web/viewer.html?file="; //cuando el pdf es de una web cualquiera

const URL_ESPACIO_DIDACTICO = 'getPostEspacioDidaConFav?';
const URL_APRENDER_CONECTADOS = 'getAprenderConectadosConFav?page=1';

//recursos didacticos
const URL_RD = 'getPostEspacioDidaConFav?level=';

//pagina
const CANTIDAD_PAGINAS = 15;

//Colores
const color_primario = Color(0xFF00b0ed);
const color_primary_dart = Color(0xFF007297);
const color_accent = Color(0xFFFFA726);