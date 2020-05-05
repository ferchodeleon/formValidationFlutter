import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:formvalidation/src/utils/utils.dart' as utils;
import 'package:formvalidation/src/models/producto_model.dart';

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productoProvider = new ProductosProvider(); //instancia del metodo provider
  File foto;

  ProductoModel producto = new ProductoModel(); //Crear y actualizar productos
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {

    ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if ( prodData != null) {
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton()
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget _crearNombre() {

    return TextFormField(
      initialValue: producto.titulo, //Valor inicial para los formularios
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if ( value.length < 3 ){
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {

    return TextFormField(
      initialValue: producto.valor.toString(), //Funciona bien con un stated full widget
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {
        if ( utils.isNumeric(value) ) {
          return null;
        } else {
          return 'Sólo números';
        }
      },
    );
  }

  Widget _crearDisponible() {

    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        producto.disponible = value;
      })
    );
  }

  Widget _crearBoton() {

    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon( Icons.save ),
      onPressed: _guardando ? null : _submit,
    );
  }

  void _submit() {

    if ( !formKey.currentState.validate() ) return; //Sirve para validar que este funcionando validator en los form

    formKey.currentState.save(); //Dispara el metodo onSaved en el form

    // print('Funcionando OK');
    // print(producto.titulo);
    // print(producto.valor);

    setState(() => _guardando = true);

    if ( producto.id == null ){ //Validación para actualizar o crear
      productoProvider.crearProducto(producto); //Envía los datos mediante el metodo creado en productos_provider instanciado arriba
    }else {
      productoProvider.editarProducto(producto);
    }

    // setState(() => _guardando = true);
    mostrarSnackbar('Registro guardado');
    Navigator.pop(context);

  }

  void mostrarSnackbar(String mensaje) {

    final snackbar = SnackBar(
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.white
            ],
          )
        ),
        height: 50.0,
        child: Center(
          child: Text(mensaje)
        ),
      ),
      duration: Duration( milliseconds: 1500 ),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto() {

    if ( producto.fotoUrl !=null ) {
      //TODO: tengo que hacer esto
      return Container(

      );
    }else {
      return Image(
        image: AssetImage( foto ?.path ?? 'assets/image/no-image.png'), //pregunta si la fotografia tiene un valor la utiliza en caso que no utiliza la por defecto
        height: 300.0,
        fit: BoxFit.cover
      );
    }
  }


  _seleccionarFoto() async{

    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async{

    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen( ImageSource origen ) async{

    foto = await ImagePicker.pickImage( //parte de la libreria de la imagen para crear la foto
      source: origen //Trae la foto de la camara
    );

    if ( foto != null) {
      //Limpieza
    }

    setState(() {});
  }
}