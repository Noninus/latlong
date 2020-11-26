import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lat Long',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Lat Long'),
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
  String lat = '';
  String long = '';
  TextEditingController controller = TextEditingController();

  void setLat(value) {
    setState(() {
      lat = value;
    });
  }

  void setLong(value) {
    setState(() {
      long = value;
    });
  }

  /// A hack to copy a string to the clipboard.
  void _copyToClipboardHack(String text) async {
    // Write text from an element to clipboard
    await FlutterClipboard.copy(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextField(
                controller: controller,
                onChanged: (v) {
                  final split = v.split(',');
                  setLat(split[0].replaceAll('.', ','));
                  setLong(split[1].replaceAll('.', ','));
                }),
            InkWell(
              onTap: () => _copyToClipboardHack(lat),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Text('Latitude: $lat'), Icon(Icons.copy)],
              ),
            ),
            InkWell(
              onTap: () => _copyToClipboardHack(long),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Text('Longitude: $long'), Icon(Icons.copy)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
