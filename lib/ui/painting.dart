import 'package:flutter/material.dart';

class PaintColor {
  final Color color;

  PaintColor(this.color);

  /// Darken a color by [percent] amount (100 = black)
// ........................................................
  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(color.alpha, (color.red * f).round(),
        (color.green * f).round(), (color.blue * f).round());
  }

  /// Lighten a color by [percent] amount (100 = white)
// ........................................................
  Color lighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
        color.alpha,
        color.red + ((255 - color.red) * p).round(),
        color.green + ((255 - color.green) * p).round(),
        color.blue + ((255 - color.blue) * p).round());
  }
}
