import 'package:flutter/material.dart';

import 'ui/tomato.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tutorial - googleflutter.com'),
        backgroundColor: const Color(0xFF444444),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomPaint(
              painter: TomatoPainter(context, false),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 15,
            height: MediaQuery.of(context).size.height / 15,
            child: CustomPaint(
              painter: TomatoPainter(context, false),
            ),
          )
        ],
      ),
    );
  }
}
