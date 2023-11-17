import "package:flutter/material.dart";
import "package:joingroup/pages/Favoritas_page.dart";
import "package:joingroup/pages/carteira_page.dart";
import "package:joingroup/pages/configuracoes_page.dart";
import "package:joingroup/pages/moedas_page.dart";


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  final PageController _pageController = PageController();

  setPaginaAtual(pagina){
    setState((){
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageView(
        controller: _pageController,
        children: [
          MoedasPage(),
          FavoritasPage(),
          CarteiraPage(),
          ConfiguracoesPage(),

        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        type:BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list) ,label:'Todas' ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Carteira'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Conta'),
        ],
        onTap: (pagina){
          _pageController.animateToPage(
            pagina,
            duration:Duration(microseconds: 400),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}