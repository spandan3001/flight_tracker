import 'package:flutter/material.dart';



class LocationText extends StatelessWidget {

  final String code;
  final String city;

  const LocationText({super.key, required this.code, required this.city});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          size: const Size(50, 50), // Specify the size of the custom paint area
          painter: StretchedTextPainter(
            text: code,
            scale: 2.5, // Adjust this value to stretch the text more or less
          ),
        ),
        Text(city,style:const TextStyle(color: Colors.black,fontSize: 12))

      ],
    );
  }
}



class StretchedTextPainter extends CustomPainter {
  final String text;
  final double scale;

  StretchedTextPainter({required this.text, this.scale = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 24.0,
          color: Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    // Calculate the position to center the text horizontally
    final dx = (size.width - textPainter.width) / 2;
    final dy = (size.height - (textPainter.height * scale)) / 2;
    final offset = Offset(dx, dy);

    canvas.save();
    // Apply the vertical scale transformation
    canvas.translate(offset.dx, offset.dy);
    canvas.scale(1.0, scale);
    // Draw the text with the applied transformation
    textPainter.paint(canvas, Offset.zero);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


