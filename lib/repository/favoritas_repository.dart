
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:joingroup/database/db_firestore.dart';
import 'package:joingroup/models/moeda.dart';
import 'package:joingroup/repository/moeda_repository.dart';
import 'package:joingroup/services/auth_service.dart';


class FavoritasRepository extends ChangeNotifier {
  List<Moeda> _lista = [];
  late FirebaseFirestore db;
  late AuthService auth;
  
  

  FavoritasRepository({required this.auth}){
    _startRepository();
  }

  _startRepository() async{
    await _startFirestore();
    await _readFavoritas();
  }

  _startFirestore(){
    db = DBFirestore.get();
  }

  _readFavoritas()async{
    if(auth.usuario != null &&  _lista.isEmpty){
      final snapshot = await db.collection('usuarios/${auth.usuario!.uid}/favoritas').get();
      snapshot.docs.forEach((doc) {
        Moeda moeda = MoedaRepository.tabela.firstWhere((moeda)=>moeda.sigla == doc.get('sigla'));
        _lista.add(moeda);  
        notifyListeners();
       });
    }
  }

  UnmodifiableListView<Moeda> get lista => UnmodifiableListView(_lista);
  saveAll(List<Moeda> moedas){
      moedas.forEach((moeda)async{
        if(!_lista.any((atual) => atual.sigla == moeda.sigla)){
          _lista.add(moeda);
           db.collection('usuarios/${auth.usuario!.uid}/favoritas')
          .doc(moeda.sigla)
          .set({
            'moeda': moeda.nome,
            'sigla': moeda.sigla,
            'preco': moeda.preco,
          });
        }
      });
      notifyListeners();
  }
 
  remove(Moeda moeda)async{
    await db.collection("usuarios/${auth.usuario!.uid}/favoritas").doc(moeda.sigla).delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
    _lista.remove(moeda); 
    notifyListeners();
  }

}