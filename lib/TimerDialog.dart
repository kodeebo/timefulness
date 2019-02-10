import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';

class TimerDialog extends StatefulWidget {
  TimerDialog({this.currentTime, this.setTimer}) : super();
  final int currentTime;
  final setTimer;

  @override
  TimerState createState() => TimerState();
}

class TimerState extends State<TimerDialog> {
  int time;

  @override
  void initState() {
    super.initState();
    time = widget.currentTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Choose number of minutes'),
      FluidSlider(
        value: time.toDouble(),
        onChanged: (double newTime) => setState(() {
              time = newTime.round();
            }),
        min: 0.0,
        max: 60.0,
      ),
      RaisedButton(
        onPressed: () => widget.setTimer(time),
        child: Text('Lagre'),
      )
    ]);
  }
}
