import 'package:flutter/material.dart';
import 'StartRoute.dart';
import 'ProgressRoute.dart';
import 'HistoryRoute.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'Metation',
    options: const FirebaseOptions(
      googleAppID: '1:896692142832:android:772b282e4231a39b',
      gcmSenderID: '896692142832',
      apiKey: 'AIzaSyBSasc5e2uGTpWWS_4kEVQIo5E_X-zMWWE',
      projectID: 'metation-1ebbc',
    ),
  );
  final Firestore firestore = Firestore(app: app);
  await firestore.settings(timestampsInSnapshotsEnabled: true);

  runApp(MaterialApp(
      title: 'Firestore Example', home: MyApp(firestore: firestore)));
}

class MyApp extends StatelessWidget {
  MyApp({this.firestore});
  final Firestore firestore;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timefulness',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(
        title: 'Timefulness',
        firestore: firestore,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.firestore}) : super(key: key);
  final String title;
  final Firestore firestore;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  void changePage(i) {
    setState(() {
      currentPage = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('torgeha').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        final DocumentSnapshot document = snapshot.data.documents[0];
        List<Widget> screens = [
          StartRoute(firestore: widget.firestore, document: document),
          ProgressRoute(),
          HistoryRoute()
        ];
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: screens[currentPage],
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Timeful')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.school), title: Text('Progress')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), title: Text('History')),
            ],
            currentIndex: currentPage,
            fixedColor: Colors.deepPurple,
            onTap: changePage,
          ),
        );
      },
    );
  }
}
