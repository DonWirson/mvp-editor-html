import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:prueba_html/bloc/html_page/bloc/html_page_bloc.dart';

class HtmlPreview extends StatelessWidget {
  const HtmlPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HtmlPageBloc, HtmlPageState>(
      builder: (context, state) {
        if (state is HtmlPreviewInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is HtmlPreviewSuccessfully) {
          //          ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text(
          //       "HTML cargado con éxito, revisa la vista \"Preview2\" ",
          //     ),
          //     duration: Duration(seconds: 2),
          //   ),
          // );
          return Html(
            data: state.htmlContent,
          );
        }
        return const Center(
          child: Text(
            "¿Por que no empiezas editando el texto? \n Luego dale al botón de HTML en primera vista",
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
