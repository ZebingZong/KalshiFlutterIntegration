import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

@pragma('vm:entry-point')
void presentedMain() => runApp(const MyPresentedApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TabPage(),
    );
  }
}

class TabPage extends StatelessWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: Center(
        child: Text(
            "This is a flutter page.",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.green)),
      ),
    );
  }
}

class MyPresentedApp extends StatelessWidget {
  const MyPresentedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyPresentedPage(),
    );
  }
}

class MyPresentedPage extends StatefulWidget {
  const MyPresentedPage({Key? key}) : super(key: key);

  @override
  State<MyPresentedPage> createState() {
    return _MyPresentedPageState();
  }
}

class _MyPresentedPageState extends State<MyPresentedPage> {
  static const _channel = MethodChannel('kalshi-flutter-integration');

  void _closeSelf() {
    _channel.invokeMethod("closeSelf");
  }

  void _openDrawer() {
    _channel.invokeMethod("openDrawer");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () { _openDrawer(); },
              icon: const Icon(Icons.menu),
            );
          },
        ),
        title: const Text('Add to app'),
        actions: <Widget>[
          IconButton(
              onPressed: () { _closeSelf(); },
              icon: const Icon(Icons.close))
        ],
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
            "This is a flutter page.",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.green)),
      ),
    );
  }
}
