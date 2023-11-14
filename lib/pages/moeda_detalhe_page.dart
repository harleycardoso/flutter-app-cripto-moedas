import "package:flutter/material.dart";
import "package:joingroup/models/moeda.dart";

class MoedaDetalhePage extends StatefulWidget {
  Moeda moeda;

  MoedaDetalhePage({super.key, required this.moeda});

  @override
  State<MoedaDetalhePage> createState() => _MoedaDetalhePageState();
}

class _MoedaDetalhePageState extends State<MoedaDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.nome),
      ),
    );
  }
}