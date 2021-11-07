import 'package:flutter/material.dart';
import 'package:positive_conversion_reframing/data_class/csv_data.dart';
import 'package:positive_conversion_reframing/view/common/components/custom_button.dart';

class QuestionnairePage extends StatefulWidget {
  final String inputWord;
  final CsvData resultCsvData;

  QuestionnairePage({
    required this.inputWord,
    required this.resultCsvData,
  });

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  String _typeQ1 = "";
  String _typeQ2 = "";
  double _currentValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "アンケート画面",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "入力したワード：${widget.inputWord}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "変換したポジティブワード",
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "・${widget.resultCsvData.paraphraseWordA}",
                  style: TextStyle(fontSize: 17.0),
                ),
                Text(
                  "・${widget.resultCsvData.paraphraseWordB ?? ""}",
                  style: TextStyle(fontSize: 17.0),
                ),
                Text(
                  "・${widget.resultCsvData.paraphraseWordC ?? ""}",
                  style: TextStyle(fontSize: 17.0),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Q1.自分の長所を新たに気づけましたか？",
                    style: TextStyle(fontSize: 17.0),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: RadioListTile(
                      secondary: Icon(Icons.thumb_up),
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text("はい"),
                      value: "Yes",
                      groupValue: _typeQ1,
                      onChanged: (value) {
                        print("選択したラジオぼたん: $value");
                        setState(
                          () {
                            _typeQ1 = value.toString();
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: RadioListTile(
                      secondary: Icon(Icons.thumb_down),
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text("いいえ"),
                      value: "No",
                      groupValue: _typeQ1,
                      onChanged: (value) {
                        print("選択したラジオぼたん: $value");
                        setState(
                          () {
                            _typeQ1 = value.toString();
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Q2.自分の性格とのマッチ度は?",
                    style: TextStyle(fontSize: 17.0),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 22.0),
                    child: Slider(
                      value: _currentValue,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _currentValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentValue = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Q3.納得のいくポジティブ変換だったか？",
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: RadioListTile(
                secondary: Icon(Icons.thumb_up),
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text("はい"),
                value: "Yes",
                groupValue: _typeQ2,
                onChanged: (value) {
                  print("選択したラジオぼたん: $value");
                  setState(
                    () {
                      _typeQ2 = value.toString();
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: RadioListTile(
                secondary: Icon(Icons.thumb_down),
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text("いいえ"),
                value: "No",
                groupValue: _typeQ2,
                onChanged: (value) {
                  print("選択したラジオぼたん: $value");
                  setState(
                    () {
                      _typeQ2 = value.toString();
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                    label: "入力内容を送信", onPressed: () => _toSendValue(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _toSendValue(BuildContext context) {
    print("送信ボタン押されたよ");
  }
}
