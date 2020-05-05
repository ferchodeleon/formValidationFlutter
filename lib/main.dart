import 'package:flutter/material.dart';

import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/page/home_page.dart';
import 'package:formvalidation/src/page/login_page.dart';
import 'package:formvalidation/src/page/producto_page.dart';
import 'package:formvalidation/src/page/registro_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Provider(
      child: MaterialApp(
        title: 'Form Validation',
        initialRoute: 'login',
        routes: {
          'login'     : (BuildContext context) =>LoginPage(),
          'home'      : (BuildContext context) =>HomePage(),
          'producto'  : (BuildContext context) =>ProductoPage(),
          'registro'  : (BuildContext context) =>RegistroPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        )
      )
    );
  }
}