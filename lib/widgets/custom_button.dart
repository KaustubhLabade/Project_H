import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color startColor;
  final Color endColor;
  final Color textColor;
  final double fontSize;
  final double borderRadius;
  final VoidCallback onPressed;

  // Constructor to accept customizable parameters
  CustomButton({
    required this.text,
    required this.onPressed,
    this.startColor = Colors.blue,
    this.endColor = Colors.lightBlueAccent,
    this.textColor = Colors.white,
    this.fontSize = 18.0,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius),
      splashColor: Colors.white.withOpacity(0.2), // Ripple effect color
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(4, 4), // Shadow position
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
