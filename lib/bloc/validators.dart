import 'dart:async';

mixin Validators {
  final validarEmail =
  StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern.toString());
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('El Email no es valido');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        // Cambiar el nombre de la variable local sink a sink2
        if (password.length >= 6) {
          sink.add(password);
        } else {
          sink.addError('Mas de 6 caracteres');
        }
      });
}
