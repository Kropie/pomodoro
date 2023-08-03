import 'package:flutter/material.dart';

import 'painting.dart';

class TomatoPainter extends CustomPainter {
  final bool isAnimating;
  final BuildContext context;
  final int tomatoCount;
  final PaintColor? colorOverride;
  final bool isTimer;
  final PaintColor tomatoColor = PaintColor(Color.fromARGB(255, 255, 29, 29));
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
          colorOverride?.lighten(50) ?? tomatoColor.lighten(60),
          colorOverride?.color ?? tomatoColor.color,
          colorOverride?.darken() ?? tomatoColor.darken(30)
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(x + width / 1.5, y + height / 3.5),
        radius: width / 2,
      ));

    canvas.drawOval(
        Rect.fromPoints(Offset(x, y), Offset(x + width * .89, height)),
        tomatoPaint);

    if (isTimer) {
      drawTimerInfo(height, x, y, width, canvas, colorOverride ?? tomatoColor);
    }

    var stemWidth = width / 15.0;
    var stemHeight = stemWidth * 2;
    drawStemLeafs(canvas, x, y, width, height, stemWidth, stemHeight);
    drawStem(x, y, width, height, stemWidth, stemHeight, canvas);
  }

  void drawTimerInfo(double height, double x, double y, double width,
      Canvas canvas, PaintColor tomatoColor) {
    // var linePaint = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = height / 100
    //   ..color = tomatoColor.darken(40);

    var linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = height / 100
      ..shader = RadialGradient(
        colors: [
          colorOverride?.lighten(50) ?? tomatoColor.color,
          colorOverride?.lighten(50) ?? tomatoColor.darken(),
          colorOverride?.color ?? tomatoColor.darken(40)
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(x + width / 1.5, y + height / 3.5),
        radius: width / 2,
      ));

    var linePath = Path()..moveTo(x, y + height / 2.2);
    linePath.arcToPoint(Offset(x + width * .89, y + height / 2.2),
        clockwise: false, radius: Radius.elliptical(width, height));
    canvas.drawPath(linePath, linePaint);
  }

  drawStem(double x, double y, double tomatoWidth, double tomatoHeight,
      double stemWidth, double stemHeight, Canvas canvas) {
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
    var startingX = x + (tomatoWidth / 2.0) - stemWidth * 1.5;
    var startingY = y + (tomatoHeight / 14.0);

    var leafLength = tomatoWidth / 4;

    Path path = Path();

    path.moveTo(startingX + leafLength, startingY - stemHeight);
    path.arcToPoint(Offset(startingX, startingY),
        radius: Radius.circular(stemHeight * 1.2));

    startingX = x + (tomatoWidth / 2.0) - stemWidth / 2;
    path.moveTo(startingX - leafLength, startingY - stemHeight);
    path.arcToPoint(Offset(startingX, startingY),
        radius: Radius.circular(stemHeight * 1.2), clockwise: false);

    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
