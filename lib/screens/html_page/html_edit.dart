import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:prueba_html/bloc/html_page/bloc/html_page_bloc.dart';
import 'package:prueba_html/services/path_services.dart';

class HtmlEdit extends StatefulWidget {
  const HtmlEdit({super.key});

  @override
  State<HtmlEdit> createState() => _HtmlEditState();
}

class _HtmlEditState extends State<HtmlEdit> {
  HtmlEditorController controller = HtmlEditorController();
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
          return const CircularProgressIndicator();
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _clearHtmlFile,
                      child: Row(
                        children: const [
                          Icon(Icons.file_copy),
                          Text("Nuevo"),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _loadHtmlFile,
                      child: Row(
                        children: const [
                          Text("Mostrar HTML"),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _saveHtmlFile,
                      child: Row(
                        children: const [
                          Icon(Icons.save),
                          Text("Guardar archivo"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HtmlEditor(
              controller: controller,
              htmlEditorOptions: const HtmlEditorOptions(
                hint: "Ingrese texto: ",
              ),
              otherOptions: const OtherOptions(
                height: 400,
              ),
            ),
          ],
        );
      },
    );
  }

  ///Guarda archivo html editado en Assets, en caso de estar vacio mostrará un snackbar informando de esto.
  void _saveHtmlFile() async {
    final htmlContent = await controller.getText();

    if (kIsWeb) {
      // var blob = html.Blob([htmlContent], 'text/plain', 'native');

      // var anchorElement = html.AnchorElement(
      //   href: html.Url.createObjectUrlFromBlob(blob).toString(),
      // )
      //   ..setAttribute("download", "${DateTime.now()}.txt")
      //   ..click();
    } else {
      //Path Provider no soporta web
      BlocProvider.of<HtmlPageBloc>(context)
          .add(SavedHtmlFile(htmlText: htmlContent));
    }
  }

  ///Carga html en Assets
  void _loadHtmlFile() {
    controller.toggleCodeView();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Cambiando de modo",
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  ///Borra contenido de html actual
  void _clearHtmlFile() {
    controller.clear();
  }

  Future<int> readCounter() async {
    try {
      final file = await PathServices().localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }
}
