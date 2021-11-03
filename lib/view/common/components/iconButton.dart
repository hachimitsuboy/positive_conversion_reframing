import 'package:flutter/material.dart';

class iconButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  iconButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.lightGreen,
        onPrimary: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
