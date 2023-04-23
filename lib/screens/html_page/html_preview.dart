import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:prueba_html/bloc/html_page/bloc/html_page_bloc.dart';

class HtmlPreview extends StatefulWidget {
  const HtmlPreview({required Key key}) : super(key: key);
  @override
  State<HtmlPreview> createState() => _HtmlPreviewState();
}

class _HtmlPreviewState extends State<HtmlPreview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<HtmlPageBloc>(context);
    return Html(
      data: bloc.htmlContent,
    );
  }
}
