import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showcaseview/showcaseview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ShowCase',
      theme: ThemeData(
        primaryColor: const Color(0xffEE5366),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ShowCaseWidget(
          builder: Builder(builder: (context) =>  MyHomePage(title: "title")),
          autoPlayDelay: const Duration(seconds: 3),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) =>
          ShowCaseWidget.of(context)
              .startShowCase([_one, _two]),
    );
  }

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Showcase(
              key: _one,
              description: 'Tap to increment!',

              onBarrierClick: () =>
                  debugPrint('Barrier clicked'),
              child: ElevatedButton(
                onPressed: () =>
                    _incrementCounter(),

                child: Text ("press me to increment")
              ),
            ),
            const Text(
              'You have pushed the button this many times:',
            ),

            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Showcase(
                key: _two, description: "click me to reset",

                child: ElevatedButton(onPressed: () { setState(() {
                  _counter = 0;
                });  },
                  child: Text ("reset counter"),

            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
