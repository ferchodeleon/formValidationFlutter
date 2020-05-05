import 'dart:convert';

import 'package:http/http.dart' as http;


class UsuarioProvider {

  final String _firebaseToken = 'AIzaSyBnFxCfzwOOJC70ug6xFbV6MapRzSTUAm8';

  Future<Map<String, dynamic>> nuevoUsuario (  String email, String password ) async{

    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if ( decodedResp.containsKey('idToken') ){
      //TODO: salvar token en el storage
      return {'ok': true, 'token': decodedResp['idToken']};
    }else {
      return {'ok': false, 'token': decodedResp['erro']['message']};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async{

    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if ( decodedResp.containsKey('idToken') ){
      //TODO: salvar token en el storage
      return {'ok': true, 'token': decodedResp['idToken']};
    }else {
      return {'ok': false, 'token': decodedResp['erro']['message']};
    }

  }



}