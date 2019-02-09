import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';

class TimerDialog extends StatelessWidget {
  TimerDialog({Key key, this.time, this.setTime}) : super(key: key);
  final double time;
  final setTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: FluidSlider(
        value: time,
        onChanged: setTime,
        min: 0.0,
        max: 60.0,
      ),
    );
  }
}
