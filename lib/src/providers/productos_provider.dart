import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {

  final String _url = 'https://flutter-varios-c7bc0.firebaseio.com'; //Url inicial de la base de datos

  Future<bool> crearProducto( ProductoModel producto ) async { //Metodo para crear los productos en la base de datos

    final url = '$_url/productos.json'; //url de la base de productos con formato json

    final resp = await http.post( url, body: productoModelToJson( producto )); //Respuesta de la base de datos

    final decodedData = json.decode(resp.body); //Estrae solo el cuerpo de la respuesta

    // print(decodedData);

    return true;

  }


  Future<List<ProductoModel>> cargarProductos() async {

    //Aquí se transforma de un mapa a un listado de productos

    final url = '$_url/productos.json'; //url de la base de productos para consultar los productos
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List(); //Se almacenan la consulta de los productos

    if (decodedData == null) return [];

    decodedData.forEach( (id, prod){

      final prodTemp = ProductoModel.fromJson(prod); //Instancia
      prodTemp.id = id;

      productos.add(prodTemp); //Agrego los productos a la lista
    });

    // print(productos);

    return productos;
  }

  Future<int> borrarProducto( String id ) async{ //metodo para borrar la información

    final url = '$_url/productos/$id.json'; //Url en firebase para ingresar a solo el producto
    final resp = await http.delete(url); //Petisión de eliminar

    print(json.decode(resp.body)); //imprimir la respuesta

    return 1; //1 quiere decir que se realizo la petición

  }

  Future<bool> editarProducto( ProductoModel producto ) async { //Metodo para crear los productos en la base de datos

    final url = '$_url/productos.json'; //url de la base de productos con formato json

    final resp = await http.post( url, body: productoModelToJson( producto )); //Respuesta de la base de datos

    final decodedData = json.decode(resp.body); //Estrae solo el cuerpo de la respuesta

    // print(decodedData);

    return true;

  }
}