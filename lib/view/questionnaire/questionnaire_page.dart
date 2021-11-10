import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:positive_conversion_reframing/data_class/csv_data.dart';
import 'package:positive_conversion_reframing/data_class/send_data.dart';
import 'package:positive_conversion_reframing/models/repositories/user_repository.dart';
import 'package:positive_conversion_reframing/view/common/components/custom_button.dart';
import 'package:positive_conversion_reframing/view_models/questionnaire_view_model.dart';
import 'package:provider/provider.dart';

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
  String _typeQ3 = "";
  String _typeQ4 = "";
  double _currentValue = 1;
  TextEditingController _question5Controller = TextEditingController();

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
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("・卒業論文のため、変換結果についてアンケートのご協力よろしくお願いいたします"),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Q1.自分の新たな長所に気づけましたか？",
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
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "Q2.ポジティブワードと自分の性格とのマッチ度は?",
                      style: TextStyle(fontSize: 17.0),
                    ),
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
                    "Q3.納得のいくポジティブ変換でしたか？",
                    style: TextStyle(fontSize: 17.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: RadioListTile(
                      secondary: Icon(Icons.thumb_up),
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text("はい"),
                      value: "Yes",
                      groupValue: _typeQ3,
                      onChanged: (value) {
                        print("選択したラジオぼたん: $value");
                        setState(
                          () {
                            _typeQ3 = value.toString();
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
                      groupValue: _typeQ3,
                      onChanged: (value) {
                        print("選択したラジオぼたん: $value");
                        setState(
                          () {
                            _typeQ3 = value.toString();
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Q4.変換が出ないことはありましたか？",
                    style: TextStyle(fontSize: 17.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: RadioListTile(
                      secondary: Icon(Icons.thumb_up),
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Text("はい"),
                      value: "Yes",
                      groupValue: _typeQ4,
                      onChanged: (value) {
                        print("選択したラジオぼたん: $value");
                        setState(
                          () {
                            _typeQ4 = value.toString();
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
                      groupValue: _typeQ4,
                      onChanged: (value) {
                        print("選択したラジオぼたん: $value");
                        setState(
                          () {
                            _typeQ4 = value.toString();
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      "（Q4で「はい」と答えた方は、実際に入力したネガティブワードを入力してください）",
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _question5Controller,
                    decoration: InputDecoration(
                      label: Text("ネガティブワード"),
                      hintText: "ネガティブワードを入力して下さい",
                    ),
                  ),
                ],
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
                    label: "入力内容を送信", onPressed: () => _toShowDialog(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _toShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("入力内容を送信します"),
          content: Text(
              "ご回答いただきましたデータについては、今回の卒業論文のみで利用することとし、"
                  "それ以外に活用することがありませんので、ご安心下さい。"),
          actions: [
            TextButton(
              onPressed: () => _sendData(context),
              child: Text("はい"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("いいえ"),
            ),
          ],
        );
      },
    );
  }

  _sendData(BuildContext context) async {
    final sendData = SendData(
      displayName: UserRepository.currentUser!.displayName,
      inputWord: widget.inputWord,
      userId: UserRepository.currentUser!.userId,
      notice: _typeQ1,
      matchDegrees: _currentValue,
      satisfactionDegrees: _typeQ3,
      existing: _typeQ4,
      notExistNegativeWord: _question5Controller.text,
    );

    final questionnaireViewModel = context.read<QuestionnaireViewModel>();
    await questionnaireViewModel.sendData(sendData);

    if (questionnaireViewModel.isSuccess) {
      Fluttertoast.showToast(msg: "入力内容を送信されました");
    } else {
      Fluttertoast.showToast(msg: "送信できませんでした");
    }

    Navigator.pop(context);
  }
}
