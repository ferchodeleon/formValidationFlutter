import 'package:flutter/material.dart';
import 'package:formvalidation/src/blocs/provider.dart';

class HomePage extends StatelessWidget {

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
      body: Container(

      ),
      floatingActionButton: _crearBoton(context),
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