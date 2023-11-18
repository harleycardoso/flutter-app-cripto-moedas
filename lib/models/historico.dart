// ignore_for_file: public_member_api_docs, sort_constructors_first
import "dart:ffi";

import "package:flutter/material.dart";

import "package:joingroup/models/moeda.dart";

class Historico {
  DateTime dataOperacao;
  String tipoOperacao;
  Moeda moeda;
  double valor;
  double quantidade;
  Historico({
    required this.dataOperacao,
    required this.tipoOperacao,
    required this.moeda,
    required this.valor,
    required this.quantidade,
  });
}
