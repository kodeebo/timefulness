import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'PhotoHero.dart';
import 'MeditationRoute.dart';
import 'TimerDialog.dart';

class StartRoute extends StatefulWidget {
  StartRoute({Key key, this.firestore, this.document}) : super(key: key);
  final DocumentSnapshot document;
  final Firestore firestore;

  @override
  StartState createState() => StartState();
}

class StartState extends State<StartRoute> {
  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    int time = widget.document['timerMinutes'];
    DocumentReference doc =
        Firestore.instance.collection('torgeha').document('settings');
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment
              .bottomRight, // 10% of the width, so there are ten blinds.
          colors: [
            const Color(0xFFFFFFEE),
            const Color(0xFF934563)
          ], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Text(
            'Start clearing your head',
            style: Theme.of(context).textTheme.display1,
          ),
          PhotoHero(
            photo: 'assets/chaos_head.png',
            width: 100.0,
            onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    MeditationRoute(startTime: time * 60))),
          ),
          Spacer(),
          Row(children: [
            IconButton(
                icon: Icon(Icons.timer),
                onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return TimerDialog(
                        currentTime: time,
                        setTimer: (int time) {
                          doc.updateData({'timerMinutes': time});
                          Navigator.pop(context);
                        },
                      );
                    })),
            Spacer(),
            IconButton(
              icon: Icon(Icons.surround_sound),
              onPressed: () {},
            ),
          ])
        ],
      ),
    );
  }
}
