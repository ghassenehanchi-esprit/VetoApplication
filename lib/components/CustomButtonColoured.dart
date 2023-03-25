import 'package:flutter/material.dart';

class CustomButtonColoured extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const CustomButtonColoured({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  _CustomButtonColouredState createState() => _CustomButtonColouredState();
}

class _CustomButtonColouredState extends State<CustomButtonColoured> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'GothamMedium',
          fontSize: 18,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    // Calculate the desired width of the button based on the width of the text
    double desiredWidth = textPainter.width + 20;
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: Container(
          width: desiredWidth,
        margin: EdgeInsets.fromLTRB(50,10,0,10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300.withOpacity(0.8),
              blurRadius: 5,
              offset: Offset(0, 2),
            )
          ],
          color: widget.color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'GothamMedium',
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
