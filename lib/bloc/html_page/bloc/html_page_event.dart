part of 'html_page_bloc.dart';

abstract class HtmlPageEvent {}

class SavedHtmlFile extends HtmlPageEvent {
  final String htmlText;

  SavedHtmlFile({required this.htmlText});
}

class LoadedHtmlFiles extends HtmlPageEvent {}

class RequestedHtmlPreview extends HtmlPageEvent {}
