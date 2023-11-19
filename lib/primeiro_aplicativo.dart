import "package:flutter/material.dart";
import "package:joingroup/pages/home_page.dart";
import "package:joingroup/widgets/auth_check.dart";

class PrimeiroAplicativo extends StatelessWidget {
  const PrimeiroAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moedas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home:AuthCheck(),

    );
  }
}