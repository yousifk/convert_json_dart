import 'dart:convert';

import 'package:flutter/material.dart';

import 'file:///C:/Users/yousi/AndroidStudioProjects/json_to_dart/lib/utils/model_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Convert Dart to Json'),
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
  final TextEditingController controllerJson = TextEditingController();
  final TextEditingController controllerDart = TextEditingController();

  void _incrementCounter() {
    final classGenerator = new ModelGenerator('Sample');
    final jsonRawData = controllerJson.text;
    DartCode dartCode = classGenerator.generateDartClasses(jsonRawData);
    print(dartCode.code);
    controllerDart.text = dartCode.code;

    var object = json.decode(jsonRawData);
    var prettyString = JsonEncoder.withIndent('  ').convert(object);

    print(prettyString);
    controllerJson.text = prettyString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controllerJson,
                  decoration: const InputDecoration(hintText: 'write json', labelText: 'Json:', border: OutlineInputBorder()),
                  autofocus: false,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controllerDart,
                  decoration: const InputDecoration(
                      hintText: 'tap convert button', labelText: 'Dart Model:', border: OutlineInputBorder()),
                  autofocus: false,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
