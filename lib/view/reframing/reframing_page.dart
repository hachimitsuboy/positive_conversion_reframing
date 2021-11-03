import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class ReframingPage extends StatefulWidget {
  final String word;

  ReframingPage({required this.word});

  @override
  _ReframingPageState createState() => _ReframingPageState();
}

class _ReframingPageState extends State<ReframingPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("平仮名変換"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(widget.word),
      )
    );
  }
}
