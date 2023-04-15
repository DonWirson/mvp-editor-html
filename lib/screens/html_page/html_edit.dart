import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:prueba_html/bloc/html_page/bloc/html_page_bloc.dart';
import 'package:prueba_html/widgets/custom_elevated_button.dart';
// import 'dart:html' as html;

class HtmlEdit extends StatefulWidget {
  const HtmlEdit({super.key});

  @override
  State<HtmlEdit> createState() => _HtmlEditState();
}

class _HtmlEditState extends State<HtmlEdit> {
  HtmlEditorController htmlController = HtmlEditorController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HtmlPageBloc, HtmlPageState>(
      listener: (context, state) {
        if (state is HtmlPageSavedSuccessfully) {
          //Muestra snackbar en caso de guardar exitosamente archivo
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Guardado archivo en: ${state.savedFilePath}",
              ),
              duration: const Duration(seconds: 3),
            ),
          );
          //Manda a recargar grilla de paginas Html en la ultima vista
          BlocProvider.of<HtmlPageBloc>(context).add(LoadedHtmlFiles());
        }
        if (state is HtmlPageSavedFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Error al guardar archivo html}",
              ),
              duration: Duration(seconds: 5),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is HtmlPageSavedInProgress) {
          //Muestra un indicador de carga mientras se guarda el archivo
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomElevatedButton(
                        text: "Nuevo",
                        iconData: Icons.file_copy,
                        onPressed: _clearHtmlFile),
                    CustomElevatedButton(
                        iconData: Icons.raw_on,
                        onPressed: _showContentAsRawHtml),
                    CustomElevatedButton(
                        iconData: Icons.save, onPressed: _saveHtmlFile),
                    CustomElevatedButton(
                        iconData: Icons.html, onPressed: _loadHtmlFile)
                  ],
                ),
              ),
              HtmlEditor(
                controller: htmlController,
                htmlEditorOptions: const HtmlEditorOptions(
                  hint: "Ingrese texto para luego guardarlo como .Html ",
                ),
                callbacks: Callbacks(onChangeContent: (String? value) {
                  BlocProvider.of<HtmlPageBloc>(context).htmlContent = value;
                }),
                otherOptions: const OtherOptions(
                  height: 400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///Guarda archivo html editado en carpeta de app, en caso de estar vacio mostrará un snackbar informando de esto.
  void _saveHtmlFile() async {
    final htmlContent = await htmlController.getText();
    if (kIsWeb) {
      //se comenta mientras, ya que el import dart:html tira errores en plataformas no web||
      // var blob = html.Blob([htmlContent], 'text/plain', 'native');

      // var anchorElement = html.AnchorElement(
      //   href: html.Url.createObjectUrlFromBlob(blob).toString(),
      // )
      //   ..setAttribute("download", "${DateTime.now()}.txt")
      //   ..click();
    } else {
      BlocProvider.of<HtmlPageBloc>(context).add(
        SavedHtmlFile(htmlText: htmlContent),
      );
    }
  }

  ///Carga html actual en vista de preview
  void _loadHtmlFile() {
    BlocProvider.of<HtmlPageBloc>(context).add(RequestedHtmlPreview());
  }

  ///Borra contenido de html actual
  void _clearHtmlFile() {
    htmlController.clear();
  }

  ///Muestra texto como su equivalente en HTML
  void _showContentAsRawHtml() {
    htmlController.toggleCodeView();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Cambiando de modo",
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
