import 'dart:math';

import 'package:flutter/material.dart';
import './segmented_circle_border.dart';

class ClockView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        shape: SegmentedCircleBorder(
            offset: -pi / 2,
            numberOfSegments: 8,
            sides: <BorderSide>[
              BorderSide(color: Color(0xFFFF0000), width: 30.0),
              BorderSide(color: Color(0xFFFF0000), width: 30.0),
              BorderSide(color: Color(0xFF0000FF), width: 30.0),
              BorderSide(color: Color(0xFFFF0000), width: 30.0),
              BorderSide(color: Color(0xFF00FF00), width: 30.0),
              BorderSide(color: Color(0xFF0000FF), width: 30.0),
              BorderSide(color: Color(0xFFFF00000), width: 30.0),
              BorderSide(color: Color(0xFF00FF00), width: 30.0),
            ]),
        child: Container(
          width: 300,
          height: 300,
        ));
  }
}
