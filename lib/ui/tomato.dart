import 'dart:math';

import 'package:flutter/material.dart';

class TomatoPainter extends CustomPainter {
  bool isAnimating;
  final BuildContext context;
  TomatoPainter(this.context, this.isAnimating);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the tomato

    var availWidth = min(size.width, 0.8 * size.height);
    var availHeight = size.height;

    var smallestDimension = min(availHeight, availWidth);
    var width = smallestDimension * 0.9;
    var height = width * 0.9;

    var x = smallestDimension * 0.1;
    var y = x;

    var tomatoPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = const RadialGradient(
        colors: [
          Color.fromARGB(255, 220, 95, 95),
          Color.fromARGB(255, 174, 59, 59)
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(x + width / 1.5, y + height / 3.0),
        radius: width / 2,
      ));

    // var tomatoPaint = Paint()
    //   ..color = Color.fromARGB(255, 255, 104, 104)
    //   ..style = PaintingStyle.fill;
    canvas.drawOval(
        Rect.fromPoints(Offset(x, y), Offset(width, height)), tomatoPaint);

    var (stemWidth, stemHeight) = drawStem(x, y, width, height, canvas);
    drawStemLeafs(canvas, x, y, width, height, stemWidth, stemHeight);
  }

  (double, double) drawStem(double x, double y, double tomatoWidth,
      double tomatoHeight, Canvas canvas) {
    var stemWidth = tomatoWidth / 15.0;
    var stemHeight = stemWidth * 2;
    var startingX = x + (tomatoWidth / 2.0) - stemWidth;
    var startingY = y + (tomatoHeight / 11.0);

    var startingPoint = (Offset(startingX - stemWidth / 2.0, startingY));
    var endingPoint =
        Offset(startingX + stemWidth / 2.0, startingY - stemHeight);
    var rrect = RRect.fromRectXY(Rect.fromPoints(startingPoint, endingPoint),
        stemWidth / 3.0, stemWidth / 3.0);

    var paint = Paint()
      ..color = const Color.fromARGB(255, 97, 168, 101)
      ..style = PaintingStyle.fill
      ..shader = const LinearGradient(colors: [
        Color.fromARGB(255, 78, 134, 81),
        Color.fromARGB(255, 97, 168, 101)
      ]).createShader(Rect.fromPoints(startingPoint, endingPoint));

    canvas.drawRRect(rrect, paint);

    return (stemWidth, stemHeight);
  }

  void drawStemLeafs(Canvas canvas, double x, double y, double width,
      double height, double stemWidth, double stemHeight) {
    var stemLeafPaint = Paint()
      ..color = const Color.fromARGB(255, 78, 134, 81)
      ..style = PaintingStyle.fill
      ..shader = const RadialGradient(
        colors: [
          Color.fromARGB(255, 86, 148, 89),
          Color.fromARGB(255, 57, 97, 58)
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(x + width, y),
        radius: width,
      ));

    canvas.drawPath(
        createStemLeafsPath(x, y, width, height, stemWidth, stemHeight),
        stemLeafPaint);
  }

  Path createStemLeafsPath(double x, double y, double tomatoWidth,
      double tomatoHeight, double stemWidth, double stemHeight) {
    var startingX = x + (tomatoWidth / 2.0) - stemWidth;
    var startingY = y + (tomatoHeight / 11.0);

    var leafLength = tomatoWidth / 4;

    Path path = Path();

    path.moveTo(startingX + leafLength, startingY);
    path.arcToPoint(Offset(startingX, startingY),
        radius: Radius.circular(stemHeight * 1.2), clockwise: false);

    path.moveTo(startingX - leafLength, startingY);
    path.arcToPoint(Offset(startingX, startingY),
        radius: Radius.circular(stemHeight * 1.2));

    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
