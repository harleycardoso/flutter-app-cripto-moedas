import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:intl/intl.dart";
import "package:joingroup/models/moeda.dart";
import "package:joingroup/repository/conta_repository.dart";
import "package:provider/provider.dart";

class MoedaDetalhePage extends StatefulWidget {
  Moeda moeda;
  MoedaDetalhePage({super.key, required this.moeda});

  @override
  State<MoedaDetalhePage> createState() => _MoedaDetalhePageState();
}

class _MoedaDetalhePageState extends State<MoedaDetalhePage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;
  late ContaRepository conta;

  comprar() async {
    
    if (_form.currentState!.validate()) {

      await conta.comprar(widget.moeda, double.parse(_valor.text));

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Compra realizada com sucesso!')),
      );
    }

    

  }

  @override
  Widget build(BuildContext context) {

    conta = Provider.of<ContaRepository>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.nome),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(widget.moeda.icone),
                    width: 50,
                  ),
                  Container(width: 10),
                  Text(real.format(widget.moeda.preco),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1,
                        color: Colors.grey[800],
                      )),
                ],
              )),
          (quantidade > 0)
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    child: Text(
                      '$quantidade ${widget.moeda.sigla}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.teal,
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 24),
                    alignment: Alignment.center,
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 24),
                ),
          Form(
            key: _form,
            child: TextFormField(
              controller: _valor,
              style: TextStyle(fontSize: 22),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Valor',
                prefixIcon: Icon(Icons.monetization_on_sharp),
                suffix: Text(
                  'reais',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Informe o valor da compra';
                } else if (double.parse(value) < 50) {
                  return 'Valor mínimo para compra R\$ 50,00 reais';
                }else if(double.parse(value) > conta.saldo){
                  return 'você não tem saldo suficiente!';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  quantidade = (value.isEmpty)
                      ? 0
                      : double.parse(value) / widget.moeda.preco;
                });
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(top: 24),
            child: ElevatedButton(
              onPressed: comprar,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Comprar',
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
