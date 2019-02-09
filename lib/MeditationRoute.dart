import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'PhotoHero.dart';
import 'utils.dart';

class MeditationRoute extends StatefulWidget {
  MeditationRoute({Key key, this.startTime}) : super(key: key);
  final double startTime;

  @override
  MeditationPageState createState() => MeditationPageState();
}

class MeditationPageState extends State<MeditationRoute> {
  double startTime;
  int time;
  var color = Color(0xFFFFFFEE);
  @override
  void initState() {
    super.initState();
    startTime = widget.startTime;
    time = widget.startTime.round();
  }

  bool meditating = false;
  bool success = false;
  Duration timeout = const Duration(seconds: 3);
  RestartableTimer _timer;
  void startTimer() {
    setState(() {
      meditating = !meditating;
    });
    if (meditating) {
      _timer = new RestartableTimer(Duration(seconds: 1), tickTheClock);
      time = startTime.round();
      color = Color.fromRGBO(0, 255, 0, 0);
    } else {
      _timer.cancel();
    }
  }

  void tickTheClock() {
    setState(() {
      if (time > 0) {
        time--;
        _timer.reset();
      } else {
        success = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String timeString = secondsToTimer(time);
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: startTime.round()),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment
                .bottomRight, // 10% of the width, so there are ten blinds.
            colors: [color, const Color(0xFF934563)],
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.fromLTRB(0, 20, 300, 0),
              icon: Icon(Icons.close),
              iconSize: 34,
              onPressed: () => Navigator.of(context).pop(),
            ),
            Spacer(),
            Text(
              !success ? timeString : 'Enjoy clarity!',
              style: Theme.of(context).textTheme.display1,
            ),
            AnimatedCrossFade(
              firstChild: PhotoHero(
                photo: 'assets/chaos_head.png',
                width: 300.0,
                onTap: startTimer,
              ),
              secondChild: PhotoHero(
                photo: 'assets/empty_head.png',
                width: 300.0,
                onTap: startTimer,
              ),
              duration: Duration(seconds: (time / 2).floor()),
              crossFadeState: !meditating
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
