import 'package:flutter/material.dart';
import 'package:joingroup/models/moeda.dart';
import 'package:joingroup/repository/moeda_repository.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {

  final tabela = MoedaRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Object> selecionado = []; 

  void _selectedItem(Moeda moeda) {
    setState(() { 
      (selecionado.contains(moeda) ? selecionado.remove(moeda) : selecionado.add(moeda));
    });
    print(selecionado.contains(moeda));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cripto Moedas'),
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int moeda) {
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              leading: (selecionado.contains(tabela[moeda]))
              ? CircleAvatar(
                child: Icon(Icons.check),
              )
              : SizedBox(
                child: Image.asset(tabela[moeda].icone),
                width: 40,
              ),
              title: Text(
                tabela[moeda].nome,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.indigo,
                ),
              ),
              
              trailing: Text(real.format(tabela[moeda].preco)),
              selected: (selecionado.contains(tabela[moeda])),
              selectedTileColor: Colors.indigo[50],
              onLongPress: (){
                _selectedItem(tabela[moeda]);
              },
              

            );
          },

          padding: EdgeInsets.all(16),
          separatorBuilder: (_, __) => Divider(),
          itemCount: tabela.length,
          

        ));
  }
}
