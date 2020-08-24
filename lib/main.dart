import 'package:clock_animation/clock.dart';
import 'package:clock_animation/pendulum.dart';
import 'package:clock_animation/style_guide.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock Animation',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 65, top: 45,bottom:25),
        color: kBackgroundColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
         
          children: <Widget>[
            ClockView(),
            Positioned(
              top: 300,
              child: PendulumView(),
            ),
          ],
        ),
      ),
    );
  }
}
