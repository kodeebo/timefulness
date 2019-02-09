import 'package:flutter/material.dart';
import 'StartRoute.dart';
import 'ProgressRoute.dart';
import 'HistoryRoute.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timefulness',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Timefulness'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

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
    List<Widget> screens = [StartRoute(), ProgressRoute(), HistoryRoute()];
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
  }
}
