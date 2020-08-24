import 'dart:math';

import 'package:clock_animation/style_guide.dart';
import 'package:flutter/material.dart';

class PendulumView extends StatefulWidget {
  @override
  _PendulumViewState createState() => _PendulumViewState();
}

class _PendulumViewState extends State<PendulumView>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animationController.addListener(() {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else if (animationController.isDismissed) {
        animationController.forward();
      }
      setState(() {});
    });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    animation =
        CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
    animation = Tween(begin: -0.5, end: 0.5).animate(animation);

    return Transform(
      alignment: FractionalOffset(0.5,0.2),
      transform: Matrix4.rotationZ(animation.value),
      child: Container(

        height: 350,
        width: 300,
        child: CustomPaint(
          painter: PendulumPainter(),
        ),
      ),
    );
  }
}

class PendulumPainter extends CustomPainter {
  var time = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = 0.5;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var arcPaint = Paint()
      ..color = kPendArcColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;

    var pendulumRod = Paint()
      ..strokeWidth = 15
      ..color = kPendRodColor;
    var pendulumBulb = Paint()..color = kPendBulbColor;

    canvas.drawLine(Offset(size.width / 2, 80), Offset(150, 250), pendulumRod);
    canvas.drawArc(Rect.fromCircle(center: center, radius: 80), pi / 4, pi / 2,
        false, arcPaint);

    canvas.drawCircle(Offset(150, 250), 20, pendulumBulb);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
