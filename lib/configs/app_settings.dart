import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  late SharedPreferences _prefrs;
  Map<String, String> locale = {
    'locale': 'pt_BR',
    'name': 'R\$',
  };

  AppSettings(){
    _startSettings();
  }

  _startSettings() async {
    await _startPreferences();
    await _readLocale();
  }

  // Inicializa preferencias
  Future<void> _startPreferences() async {
    _prefrs = await SharedPreferences.getInstance();
  }  

  // Ler preferencias e notificar listeners
  _readLocale(){
    final local = _prefrs.getString('local') ?? 'pt_BR';
    final name = _prefrs.getString('name') ?? 'R\$';
    locale = {
      'locale':local,
      'name':name,
    };

    notifyListeners();
  }
  // Método publico para classes alterarem o locale
  setLocale(String local, String name)async{
    await _prefrs.setString('local', local);
    await _prefrs.setString('name', name);
    await _readLocale();
  }
}