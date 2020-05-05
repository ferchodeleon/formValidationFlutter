import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

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

    final url = '$_url/productos/${producto.id}.json'; //url de la base de productos con el id para actualizar

    final resp = await http.put( url, body: productoModelToJson( producto )); //Put para actualizar post para crear

    final decodedData = json.decode(resp.body); //Estrae solo el cuerpo de la respuesta

    print(decodedData);

    return true;

  }

  Future<String> subirImagen(File imagen) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dehb6nrxn/image/upload?upload_preset=pkwxwo1n');
    final mimeType = mime(imagen.path).split('/'); //Con este se el tipo de archivo split sirve para separar

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1])
    );

    imageUploadRequest.files.add(file); //Esta forma se adjunta el archivo, se puede adjuntar multiples archivos

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ){
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];

  }
}