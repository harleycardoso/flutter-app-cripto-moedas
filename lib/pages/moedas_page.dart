import 'package:flutter/material.dart';
import 'package:joingroup/models/moeda.dart';
import 'package:joingroup/pages/moeda_detalhe_page.dart';
import 'package:joingroup/repository/favoritas_repository.dart';
import 'package:joingroup/repository/moeda_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Moeda> selecionado = [];
  late FavoritasRepository favoritas;


  limpaSelecionado(){
    setState(() {
      selecionado = [];
    });
  }

  _selectedItem(Moeda moeda) {
    setState(() {
      (selecionado.contains(moeda)
          ? selecionado.remove(moeda)
          : selecionado.add(moeda));
    });
  }

  _appBarDinamico() {
    if (selecionado.isEmpty) {
      return AppBar(
        centerTitle: true,
        title: Text('Cripto Moedas'),
        
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
           limpaSelecionado;
          },
        ),
        centerTitle: true,
        title: Text('${selecionado.length} seleção'),
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
      );
    }
  }

  mostrarDetalhes(Moeda moeda){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MoedaDetalhePage(moeda: moeda),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {

    //favoritas = Provider.of<FavoritasRepository>(context);
    favoritas = context.watch<FavoritasRepository>();

    return Scaffold(
      appBar: _appBarDinamico(),
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
            title: Row(
              children:[
                Text(
                tabela[moeda].nome,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.indigo, 
                  ),
                ),
                if(favoritas.lista.contains(tabela[moeda]))
                  Icon(Icons.circle,color:Colors.amber,size:8),
                ],
            ),
            trailing: Text(real.format(tabela[moeda].preco)),
            selected: (selecionado.contains(tabela[moeda])),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              _selectedItem(tabela[moeda]);
            },
            onTap: () => mostrarDetalhes(tabela[moeda]),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (selecionado.isNotEmpty)
          ? FloatingActionButton.extended(
              onPressed: () {
                favoritas.saveAll(selecionado);
                limpaSelecionado;
              },
              icon: Icon(Icons.star),
              label: Text(
                'Favoritar',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ))
          : null,
    );
  }
}
