import 'package:flutter/material.dart';
import 'package:joingroup/primeiro_aplicativo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:joingroup/repository/favoritas_repository.dart';
import 'package:joingroup/services/auth_service.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
    create: (context) => FavoritasRepository(),
    child: PrimeiroAplicativo(),
    ),
  );
}