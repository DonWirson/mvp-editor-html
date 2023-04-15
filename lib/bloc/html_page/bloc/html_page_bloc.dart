import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:prueba_html/services/path_services.dart';

part 'html_page_event.dart';
part 'html_page_state.dart';

class HtmlPageBloc extends Bloc<HtmlPageEvent, HtmlPageState> {
  //Mantiene texto actual de archivo html actual
  String? htmlContent = "";
  HtmlPageBloc() : super(HtmlPageInitial()) {
    on<SavedHtmlFile>(_saveHtmlFile);
    on<LoadedHtmlFiles>(_loadHtmlFiles);
  }

  Future<void> _saveHtmlFile(
      SavedHtmlFile event, Emitter<HtmlPageState> emit) async {
    emit(HtmlPageSavedInProgress());
    try {
      final file = await PathServices().localFile;
      var response = await file.writeAsString(event.htmlText);
      emit(HtmlPageSavedSuccessfully(savedFilePath: response.path));
    } catch (e) {
      emit(HtmlPageSavedFailed());
    }
  }

  Future<void> _loadHtmlFiles(
      LoadedHtmlFiles event, Emitter<HtmlPageState> emit) async {
    emit(LoadedPageInProgress());
    try {
      var response = await PathServices().getFiles();
      List<File> archivosHtml = [];
      for (var element in response) {
        if (element is File && element.path.contains(".html")) {
          archivosHtml.add(element);
        }
      }
      emit(LoadedPageSavedSuccessfully(htmlPagesSaved: archivosHtml));
    } catch (e) {
      emit(LoadedPageSavedFailed());
    }
  }
}
