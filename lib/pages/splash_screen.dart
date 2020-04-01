import 'package:flutter/material.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  final String imgPath;
  SplashScreen({
    Key key,
    this.imgPath,
  }) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animationBall;
  Animation<double> shadowBall;
  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    final curvedBallAnimation = CurvedAnimation(
      parent: animController,
      curve: Curves.bounceOut,
      //reverseCurve: Curves.easeIn,
    );

    animationBall = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curvedBallAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) animController.reverse();
        else if (status == AnimationStatus.dismissed) animController.forward();
      });

    final curvedShadowAnimation = CurvedAnimation(
      parent: animController,
      curve: Curves.bounceOut,
      //reverseCurve: Curves.easeIn,
    );

    shadowBall = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curvedShadowAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) animController.reverse();
        else if (status == AnimationStatus.dismissed) animController.forward();
      });
    animController.forward();

    //Call HomePage
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Variables
    var size = MediaQuery.of(context).size;
    double logoSize = size.height * 0.07; //50
    double shadowSizeWidth = logoSize - 10;
    double shadowSizeHeight = shadowSizeWidth / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: size.height * 0.3,
                  child: Stack(
                    children: <Widget>[
                      //Shadow
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: shadowBall.value * shadowSizeHeight,
                          width: shadowBall.value * shadowSizeWidth,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: new BorderRadius.all(
                              Radius.elliptical(
                                shadowSizeWidth,
                                shadowSizeHeight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Ball
                      Align(
                        alignment: Alignment.topCenter,
                        child: Transform.translate(
                            offset: Offset(
                              0,
                              ((size.height * 0.22) * animationBall.value),
                            ),
                            child: widget.imgPath != null
                                ? Image.asset(widget.imgPath, height: logoSize)
                                : CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}
