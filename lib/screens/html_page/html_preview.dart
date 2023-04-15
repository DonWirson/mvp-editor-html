import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:prueba_html/bloc/html_page/bloc/html_page_bloc.dart';

class HtmlPreview extends StatelessWidget {
  const HtmlPreview({super.key});

  @override
  Widget build(BuildContext context) {
    var contentHtmlTopreview =
        BlocProvider.of<HtmlPageBloc>(context).htmlContent;
    if (contentHtmlTopreview != null) {
      return Html(
        data: contentHtmlTopreview,
      );
    }
    return const Center(child: Text("¿Por que no empiezas editando el texto?"));
  }
}
