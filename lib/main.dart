import 'package:flutter/material.dart';

import 'package:formvalidation/src/blocs/provider.dart';
import 'package:formvalidation/src/page/home_page.dart';
import 'package:formvalidation/src/page/login_page.dart';
import 'package:formvalidation/src/page/producto_page.dart';
import 'package:formvalidation/src/page/registro_page.dart';
import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized(); //inicio el widget para solución del error de instancia
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final prefs = new PreferenciasUsuario();
    print(prefs.token);

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