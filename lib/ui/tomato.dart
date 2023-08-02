import 'package:flutter/material.dart';

import 'painting.dart';

class TomatoPainter extends CustomPainter {
  final bool isAnimating;
  final BuildContext context;
  final int tomatoCount;
  final PaintColor? colorOverride;
  final bool isTimer;
  TomatoPainter(this.context, this.isAnimating,
      {this.tomatoCount = 1, this.colorOverride, this.isTimer = true});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the tomato
    var availWidth = size.width / tomatoCount;
    var x = availWidth * .1;
    var y = availWidth * .1;
    var width = availWidth * .9;
    var height = width * 0.9;

    for (var tomatoIdx = 0; tomatoIdx < tomatoCount; tomatoIdx++) {
      paintTomato(x, width, y, height, canvas);
      x += width;
    }
  }

  void paintTomato(
      double x, double width, double y, double height, Canvas canvas) {
    var tomatoPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(
        colors: [
          colorOverride?.lighten(25) ?? const Color.fromARGB(255, 220, 95, 95),
          colorOverride?.color ?? const Color.fromARGB(255, 174, 59, 59)
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(x + width / 1.5, y + height / 3.0),
        radius: width / 2,
      ));

    canvas.drawOval(
        Rect.fromPoints(Offset(x, y), Offset(x + width * .89, height)),
        tomatoPaint);

    if (isTimer) {
      drawTimerInfo(height, x, y, width, canvas,
          colorOverride ?? PaintColor(const Color.fromARGB(255, 220, 95, 95)));
    }

    var (stemWidth, stemHeight) = drawStem(x, y, width, height, canvas);
    drawStemLeafs(canvas, x, y, width, height, stemWidth, stemHeight);
  }

  void drawTimerInfo(double height, double x, double y, double width,
      Canvas canvas, PaintColor tomatoColor) {
    var linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = height / 100
      ..color = tomatoColor.darken(40);

    var linePath = Path()..moveTo(x, y + height / 2.2);
    linePath.arcToPoint(Offset(x + width * .89, y + height / 2.2),
        clockwise: false, radius: Radius.elliptical(width, height));
    canvas.drawPath(linePath, linePaint);
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
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(colors: [
        colorOverride?.darken() ?? const Color.fromARGB(255, 78, 134, 81),
        colorOverride?.color ?? const Color.fromARGB(255, 97, 168, 101)
      ]).createShader(Rect.fromPoints(startingPoint, endingPoint));

    canvas.drawRRect(rrect, paint);

    return (stemWidth, stemHeight);
  }

  void drawStemLeafs(Canvas canvas, double x, double y, double width,
      double height, double stemWidth, double stemHeight) {
    var stemLeafPaint = Paint()
      ..color = const Color.fromARGB(255, 78, 134, 81)
      ..style = PaintingStyle.fill
      ..shader = RadialGradient(
        colors: [
          colorOverride?.darken() ?? const Color.fromARGB(255, 86, 148, 89),
          colorOverride?.darken() ?? const Color.fromARGB(255, 57, 97, 58)
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
