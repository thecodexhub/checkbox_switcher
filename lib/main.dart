import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter checkbox Switcher',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  bool isChecked = false;

  Animation<Alignment> _alignAnimation;
  Animation<Color> _colorAnimation;
  Animation<double> _opacityAnimation;
  AnimationController _controller2;

  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    _controller2 =
    AnimationController(vsync: this, duration: Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    _alignAnimation =
        Tween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(_controller2);
    _colorAnimation = ColorTween(begin: Colors.grey[500], end: Colors.green)
        .animate(_controller2);
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller2);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      isChecked = !isChecked;
    });
    _controller.reverse();
    isChecked ? _controller2.forward() : _controller2.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTapUp: _onTapUp,
              onTapDown: _onTapDown,
              child: Transform.scale(
                scale: _scale,
                child: Container(
                  height: 90.0,
                  width: 180.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0.0, 4.0),
                          blurRadius: 100.0,
                          spreadRadius: 10.0,
                        ),
                      ],
                      color: Colors.white),
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  alignment: _alignAnimation.value,
                  child: Container(
                    width: 70.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: _colorAnimation.value),
                    child: Center(
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: Icon(
                          Icons.done,
                          size: 60.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
