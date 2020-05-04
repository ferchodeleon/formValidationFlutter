import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {

  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: <Widget>[
      //       Text('Email: ${bloc.email}'), //Se recibe la información del provider de bloc
      //       Text('Email: ${bloc.password}')
      //     ],
      //   ),
      // ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

 Widget _crearListado() {
   return FutureBuilder(
     future: productosProvider.cargarProductos(),
     builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
       if (snapshot.hasData) {
         return Container();
       }else {
         return Center(child: CircularProgressIndicator());
       }
     },
   );
 }

  _crearBoton( BuildContext context ){

    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon( Icons.add ),
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }
}