import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:positive_conversion_reframing/view/reframing/reframing_page.dart';
import 'package:positive_conversion_reframing/view_models/reframing_view_model.dart';
import 'package:provider/provider.dart';

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
                    primary: Colors.blue,
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

  _toConvertHiragana(BuildContext context) async {
    if (_textEditingController.text.length > 0) {
      final reframingViewModel = context.read<ReframingViewModel>();
      final enteredHiraganaWord = await reframingViewModel.convertToHiragana(
          enteredWord: _textEditingController.text);

      //言い換え表現の取得 //homeScreenでインディケータを回すように仕様変更
      await reframingViewModel.getParaphrase(word: enteredHiraganaWord);
      if (!reframingViewModel.isSuccess) {
        Fluttertoast.showToast(
          msg: "他のワードでお試しください",
        );
        return;
      }
      //画面遷移
      _toCountNumberPage(context, enteredHiraganaWord);
    }
    return;
  }

  _toCountNumberPage(BuildContext context, String resultWord) {
    //画面遷移
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReframingPage(
          hiraganaWord: resultWord, inputWord: _textEditingController.text,
        ),
      ),
    );
  }
}
