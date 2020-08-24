import 'dart:async';
import 'dart:math';

import 'package:clock_animation/style_guide.dart';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 280,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var time = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    //CALCULATIONS
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);

    var radius = min(centerX, centerY);
    //
    //CLOCK FILL BRUSH
    var fillClock = Paint()..color = kClockFillColor;
    //
    //CLOCK OUTLINE BRUSH
    var outlineClock = Paint()
      ..color = kClockOutlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;
    //
    //CENTER DOT BRUSH
    var centerDot = Paint()
      ..color = kCenterColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 15;
    //
    //SECOND HAND BRUSH
    var secondHand = Paint()
      ..strokeWidth = 3.5
      ..color = kSecHandColor
      ..strokeCap = StrokeCap.round;
    //
    //MINUTE HAND BRUSH
    var minuteHand = Paint()
      ..strokeWidth = 5
      ..color = kMinHandColor
      ..strokeCap = StrokeCap.round;

    //
    //HOUR HAND BRUSH
    var hourHand = Paint()
      ..strokeWidth = 6.5
      ..color = kHourHandColor
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 20, fillClock);
    canvas.drawCircle(center, radius - 20, outlineClock);
    //

    //

    //
    var hourHandX =
        centerX + 70 * cos((time.hour * 30 + time.minute * 0.5) * pi / 180);
    var hourHandY =
        centerX + 70 * sin((time.hour * 30 + time.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHand);
    var minHandX = centerX + 82 * cos(time.minute * 6 * pi / 180);
    var minHandY = centerX + 82 * sin(time.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minuteHand);
    var secHandX = centerX + 90 * cos(time.second * 6 * pi / 180);
    var secHandY = centerX + 90 * sin(time.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secondHand);
    canvas.drawCircle(center, 12, centerDot);
    //
    //
    var minDashBrush = Paint()
      ..strokeWidth = 2
      ..color = kDashColor
      ..strokeCap = StrokeCap.round;
    var hourDashBrush = Paint()
      ..strokeWidth = 4
      ..color = kDashColor
      ..strokeCap = StrokeCap.round;

    var outerCircleRadius = radius + 10;
    var innerCircleRadius = radius - 5;

    for (var i = 0; i <= 360; i += 6) {
      var x1 = centerX + outerCircleRadius * 0.95 * cos(i * pi / 180);
      var y1 = centerY + outerCircleRadius * 0.95 * sin(i * pi / 180);
      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerY + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), minDashBrush);
    }
    for (var i = 0; i <= 360; i += 30) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerY + outerCircleRadius * sin(i * pi / 180);
      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerY + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), hourDashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
