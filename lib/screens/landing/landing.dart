import 'package:flutter/material.dart';
import 'package:prueba_html/screens/html_page/html_edit.dart';
import 'package:prueba_html/screens/html_page/html_load.dart';
import 'package:prueba_html/screens/html_page/html_preview.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final pageController = PageController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: "Editar html",
            icon: Icon(Icons.edit_outlined),
          ),
          BottomNavigationBarItem(
            label: "Html en tiempo real",
            icon: Icon(Icons.html_outlined),
          ),
          BottomNavigationBarItem(
            label: "Abrir html",
            icon: Icon(Icons.file_open_outlined),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (value) => setState(() {
          selectedIndex = value;
        }),
      ),
      appBar: AppBar(
        title: const Text("Módulo de prueba Html"),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: const [
          HtmlEdit(),
          HtmlPreview(),
          HtmlLoad(),
        ],
      ),
    );
  }
}
