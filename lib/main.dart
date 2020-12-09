import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Scratch Card Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final key = GlobalKey<ScratcherState>();
  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  _opacity = 0.0;
                  scratchCardDialog(context);
                },
                child: Text('Scratch Card'),
                color: Colors.blue.shade900,
                textColor: Colors.white,
                splashColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scratchCardDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue.shade900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          title: Align(
            alignment: Alignment.center,
            child: Text(
              'You\'ve won a scratch card',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          content: StatefulBuilder(builder: (context, StateSetter setState) {
            return Scratcher(
              key: key,
              accuracy: ScratchAccuracy.low,
              threshold: 80,
              brushSize: 50,
              onThreshold: () {
                setState(() {
                  _opacity = 1;
                  key.currentState.reveal(duration: const Duration(milliseconds: 2000));
                });
              },
              onChange: (value) {},
              image: Image.asset("assets/flutter.png"),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 250),
                opacity: _opacity,
                child: Container(
                  height: 300,
                  width: 300,
                  alignment: Alignment.center,
                  child: Text(
                    "You have won ₹100000!\n Have a nice day..!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.orange),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
