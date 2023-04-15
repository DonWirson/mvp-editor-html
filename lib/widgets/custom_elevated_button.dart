import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, this.text, required this.iconData, required this.onPressed});
  final String? text;
  final IconData iconData;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          children: [
            if (text != null) Text(text!),
            Icon(iconData),
          ],
        ),
      ),
    );
  }
}
