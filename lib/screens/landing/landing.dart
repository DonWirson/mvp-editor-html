import 'package:flutter/material.dart';
import 'package:prueba_html/screens/html_page/html_edit.dart';
import 'package:prueba_html/screens/html_page/html_load.dart';
import 'package:prueba_html/screens/html_page/html_preview.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  final pageController = PageController();
  late TabController _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabBar(
        controller: _tabController,
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.grey,
        dividerColor: Colors.black,
        tabs: const [
          Tab(
            text: "Editar html",
            icon: Icon(Icons.edit_outlined),
          ),
          Tab(
            text: "Preview HTML",
            icon: Icon(Icons.html_outlined),
          ),
          Tab(
            text: "Abrir html",
            icon: Icon(Icons.file_open_outlined),
          ),
        ],
        onTap: (value) {
          selectedIndex = value;
          setState(() {});
        },
      ),
      appBar: AppBar(
        title: const Text("Módulo de prueba Html"),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          const HtmlEdit(),
          HtmlPreview(
            key: UniqueKey(),
          ),
          const HtmlLoad(),
        ],
      ),
    );
  }
}
