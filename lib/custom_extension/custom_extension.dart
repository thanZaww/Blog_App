import 'package:flutter/cupertino.dart';

extension CustomExtension on Widget {
  Widget get center => Center(child: this);

  Widget scaleEvenly(double scale) {
    return Transform.scale(scale: scale, child: this);
  }
}
