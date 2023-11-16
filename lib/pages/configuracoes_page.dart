import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:joingroup/configs/app_settings.dart';
import 'package:joingroup/repository/conta_repository.dart';
import 'package:provider/provider.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State <ConfiguracoesPage> createState() =>  ConfiguracoesPageState();
}

class  ConfiguracoesPageState extends State <ConfiguracoesPage> {
  @override
  Widget build(BuildContext context) {
    final conta = context.watch<ContaRepository>();
    final loc = context.read<AppSettings>().locale;
    NumberFormat real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
    return Scaffold(
      appBar: AppBar(
        title:Text('Configuracoes'),
      ),
      body:Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              title:Text('saldo'),
              subtitle: Text(real.format(conta.saldo),
              style: TextStyle(
                fontSize: 25, 
                color: Colors.indigo,
                ),),
                trailing: IconButton(onPressed: updateSaldo , icon: Icon(Icons.edit),),
            ),
            Divider(),
          ],
        ))
    );
  }
  updateSaldo()async{

    final form = GlobalKey<FormState>();
    final valor = TextEditingController();
    final conta = context.read<ContaRepository>();

    valor.text = conta.saldo.toString();

    AlertDialog dialog = AlertDialog(
      title: Text('Atualizar o saldo'),
      content: Form(
        key: form,
        child: TextFormField(
          controller:valor,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
          ],
          validator: (valor){
            if(valor!.isEmpty) return 'Informe o valor do saldo';
            return null;
          },
        )
      ),
      actions:[
        TextButton(onPressed: () => Navigator.pop(context),child:Text('cancelar')),
        TextButton(
          onPressed: (){
            if(form.currentState!.validate()){
              conta.setSaldo(double.parse(valor.text));
              Navigator.pop(context);
            }
          }, 
          child: Text('Salvar')),
      ],
    );
    showDialog(context: context, builder: (context)=>dialog);
  }
}