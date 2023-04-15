import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:prueba_html/bloc/html_page/bloc/html_page_bloc.dart';

class HtmlLoad extends StatefulWidget {
  const HtmlLoad({super.key});

  @override
  State<HtmlLoad> createState() => _HtmlLoadState();
}

class _HtmlLoadState extends State<HtmlLoad> {
  List<File> archivosHtml = [];

  @override
  void initState() {
    super.initState();
    //Gatilla evento que va a buscar paginas Html Guardadas de forma local
    if (!kIsWeb) {
      BlocProvider.of<HtmlPageBloc>(context).add(LoadedHtmlFiles());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HtmlPageBloc, HtmlPageState>(
      listener: (context, state) {
        if (state is LoadedPageSavedSuccessfully) {
          if (!kIsWeb) {
            //Limpia lista de Archivos Html, esto para evitar la duplicación.
            archivosHtml.clear();
            archivosHtml = state.htmlPagesSaved;
            setState(() {});
          }
        }
      },
      child: archivosHtml.isEmpty || !kIsWeb
          ? const Center(
              child: Text(
                  "Empieza guardando archivos HTML, aparecerán acá, solo para la versión movil"),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: archivosHtml.length,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    child: Card(
                      color: Colors.blue.shade50,
                      child: ListTile(
                        title: Text(archivosHtml[index].path),
                      ),
                    ),
                    onTap: () {
                      //Despliega dialogo para abrir archivo Html creado
                      var file = archivosHtml[index].path;
                      OpenFile.open(file);
                    },
                  ),
                );
              },
            ),
    );
  }
}
