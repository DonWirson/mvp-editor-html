part of 'html_page_bloc.dart';

abstract class HtmlPageState {}

class HtmlPageInitial extends HtmlPageState {}

class HtmlPageSavedInProgress extends HtmlPageState {}

class HtmlPageSavedSuccessfully extends HtmlPageState {
  final String savedFilePath;

  HtmlPageSavedSuccessfully({required this.savedFilePath});
}

class HtmlPageSavedFailed extends HtmlPageState {}

class LoadedPageInProgress extends HtmlPageState {}

class LoadedPageSavedSuccessfully extends HtmlPageState {
  final List<File> htmlPagesSaved;

  LoadedPageSavedSuccessfully({required this.htmlPagesSaved});
}

class LoadedPageSavedFailed extends HtmlPageState {}

class HtmlPreviewInProgress extends HtmlPageState {}

class HtmlPreviewSuccessfully extends HtmlPageState {
  final String? htmlContent;

  HtmlPreviewSuccessfully({required this.htmlContent});
}

class HtmlPreviewdFailed extends HtmlPageState {}
