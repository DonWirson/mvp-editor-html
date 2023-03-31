import 'package:flutter/material.dart';

//Actualmente no usado
class NavigigationModel {
  final String label;
  final Widget indexedStackWidget;
  final BottomNavigationBarItem bottomNavigationBarItem;

  NavigigationModel(
      {required this.label,
      required this.indexedStackWidget,
      required this.bottomNavigationBarItem});
}
