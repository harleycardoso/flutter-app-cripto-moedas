import "package:flutter/material.dart";
import "package:joingroup/pages/Favoritas_page.dart";
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
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list) ,label:'Todas' ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas'),
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