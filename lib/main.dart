import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nested ListViews',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({
    Key key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nested ListViews'),
      ),
      body: ListView.builder(
        itemBuilder: (context, outerIndex) {
          return ListView.builder(
            itemBuilder: (context, innerIndex) {
              print('Building row: Outer = $outerIndex, Inner = $innerIndex');

              return Text('Outer = $outerIndex, Inner = $innerIndex');
            },
            itemCount: 10,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
