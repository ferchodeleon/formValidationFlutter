import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {

  final String _url = 'https://flutter-varios-c7bc0.firebaseio.com'; //Url inicial de la base de datos

  Future<bool> crearProducto( ProductoModel producto ) async { //Metodo para crear los productos en la base de datos

    final url = '$_url/productos.json'; //url de la base de productos con formato json

    final resp = await http.post( url, body: productoModelToJson( producto )); //Respuesta de la base de datos

    final decodedData = json.decode(resp.body); //Carga los datos y respuesta de la base de datos

    print(decodedData);

    return true;

  }
}