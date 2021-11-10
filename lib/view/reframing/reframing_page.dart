import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:positive_conversion_reframing/view/common/components/custom_button.dart';
import 'package:positive_conversion_reframing/view/questionnaire/questionnaire_page.dart';
import 'package:positive_conversion_reframing/view_models/reframing_view_model.dart';
import 'package:provider/provider.dart';

class ReframingPage extends StatelessWidget {
  final hiraganaWord;
  final inputWord;

  ReframingPage({
    required this.hiraganaWord,
    required this.inputWord,
  });

  TextEditingController _inputStoryController1 = TextEditingController();
  TextEditingController _inputStoryController2 = TextEditingController();
  TextEditingController _inputStoryController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String?> paraphraseList = [];
    final reframingViewModel = context.read<ReframingViewModel>();
    //awaitする必要がある（csvDataに値が入ってるのに、awaitしてないから elseにいく)
    if (!reframingViewModel.isLoading && reframingViewModel.csvData == null) {
      //2 63
      Future(() async {
        await getParaphrase(reframingViewModel);
      });
    }

    if (reframingViewModel.csvData != null) {
      paraphraseList
        ..add(reframingViewModel.csvData!.paraphraseWordA)
        ..add(reframingViewModel.csvData!.paraphraseWordB)
        ..add(reframingViewModel.csvData!.paraphraseWordC);

    } else {
      paraphraseList.add("コーパスに一致するネガティブ語が見つかりませんでした");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "結果画面",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer<ReframingViewModel>(
        builder: (context, model, child) {
          if (model.isLoading) {
            return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "「$inputWord」の変換結果",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          "変換されたポジティブワードから、想起される体験談がある場合は入力してください。"
                          "ない場合は「なし」と入力してください.",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 10,
                          child: ListTile(
                            leading: Text(
                              "1",
                              style: TextStyle(fontSize: 18),
                            ),
                            title: Text(
                              paraphraseList[0]!,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: _inputStoryController1,
                          decoration: InputDecoration(
                            hintText: "体験談を入力してください",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      if (paraphraseList[1] == null) Container() else Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    elevation: 10,
                                    child: ListTile(
                                      leading: Text(
                                        "2",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      title: Text(
                                        paraphraseList[1]!,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextField(
                                    controller: _inputStoryController2,
                                    decoration: InputDecoration(
                                      hintText: "体験談を入力してください",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 40,
                      ),
                      if (paraphraseList[2] == null) Container() else Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    elevation: 10,
                                    child: ListTile(
                                      leading: Text(
                                        "3",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      title: Text(
                                        paraphraseList[2]!,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextField(
                                    controller: _inputStoryController3,
                                    decoration: InputDecoration(
                                      hintText: "体験談を入力してください",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            label: "アンケート画面へ",
                            onPressed: () => toQuestionnairePage(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
          } else {
            return Center(
                  child: CircularProgressIndicator(),
                );
          }
        },
      ),
    );
  }

  Future<void> getParaphrase(ReframingViewModel reframingViewModel) async {
    await reframingViewModel.getParaphrase(word: hiraganaWord);
  }

  toQuestionnairePage(BuildContext context) {
    final reframingViewModel = context.read<ReframingViewModel>();
    print("アンケート画面へ行くよ");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionnairePage(
            inputWord: inputWord, resultCsvData: reframingViewModel.csvData!),
      ),
    );
  }
}
