import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:positive_conversion_reframing/view/reframing/reframing_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ポジティブ変換",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
            ),
            Text(
              "あなたのネガティブな一面は？",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: _textEditingController,
              ),
            ),
            SizedBox(
              height: 38.0,
            ),
            //TODO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () => _toConvertHiragana(context),
                  child: Text(
                    "変換",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _toConvertHiragana(BuildContext context) async{
    final data = _textEditingController.text;
    final urlString = "https://labs.goo.ne.jp/api/hiragana";
    final uri = Uri.parse(urlString);
    final headers = {"content-type": "application/json"};
    final body = {
      "app_id" : "86150de65e763b32e3c18dd66045195187220aa4d2c5064703b846e8c84e77a8",
      "sentence" : "$data",
      "output_type" : "hiragana"
    };

    final res = await http.post(uri, headers: headers, body: jsonEncode(body));
    // print(res.body);
    var resultBody = json.decode(res.body);
    var resultWord = resultBody["converted"];
    print("かな変換後: $resultWord");
    //画面遷移
    _toCountNumberPage(context, resultWord);

  }



  _toCountNumberPage(BuildContext context, String resultWord) {
    if (_textEditingController.text != "") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ReframingPage(
            word: resultWord,
          ),
        ),
      );
    }
  }
}
