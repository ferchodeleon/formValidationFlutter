import 'dart:async';

class Validators {

  final validarEmail = StreamTransformer<String, String>.fromHandlers( //Aquí se definen los datos que van a ingresar o salir, este metodo funciona como el stream transform
    handleData: (email, sink) {

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regExp = new RegExp(pattern);

      if ( regExp.hasMatch( email ) ) {
        sink.add( email );
      }else {
        sink.addError('No es un email valido');
      }
    }
  );


  final validarPassword = StreamTransformer<String, String>.fromHandlers( //Aquí se definen los datos que van a ingresar o salir, este metodo funciona como el stream transform
    handleData: (password, sink) {

      if ( password.length >= 6 ) { //Si se cumple agrega el valor string que se acaba de ingresar
        sink.add(password);
      }else {
        sink.addError('Ingrese más de 6 caracteres');
      }
    }
  );

}