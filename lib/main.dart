

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:joingroup/configs/app_settings.dart';
import 'package:joingroup/primeiro_aplicativo.dart';
import 'package:joingroup/repository/conta_repository.dart';
import 'package:joingroup/repository/favoritas_repository.dart';
import 'package:joingroup/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
 
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  // This is the last thing you need to add. 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService(),),
        ChangeNotifierProvider(create: (context) => ContaRepository(),),
        ChangeNotifierProvider(create: (context) => AppSettings(),),
        ChangeNotifierProvider(create: (context) => FavoritasRepository(
          auth: context.read<AuthService>(),
        ),),
      ],
      child: PrimeiroAplicativo(),
    ),
  );
}