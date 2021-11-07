import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:positive_conversion_reframing/view/common/components/custom_button.dart';
import 'package:positive_conversion_reframing/view/common/components/word_card.dart';
import 'package:positive_conversion_reframing/view/questionnaire/questionnaire_page.dart';
import 'package:positive_conversion_reframing/view_models/reframing_view_model.dart';
import 'package:provider/provider.dart';

class ReframingPage extends StatelessWidget {
  final hireganaWord;
  final inputWord;

  ReframingPage({
    required this.hireganaWord,
    required this.inputWord,
  });

  @override
  Widget build(BuildContext context) {
    List<String> paraphraseList = [];
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
        ..add(reframingViewModel.csvData!.paraphraseWordB ?? "B")
        ..add(reframingViewModel.csvData!.paraphraseWordC ?? "C");
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
          return model.isLoading
              ? Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "「$inputWord」の変換結果",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        LimitedBox(
                          maxHeight: 250,
                          child: WordCard(resultList: paraphraseList),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              label: "アンケート画面へ,",
                              onPressed: () => toQuestionnairePage(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Future<void> getParaphrase(ReframingViewModel reframingViewModel) async {
    await reframingViewModel.getParaphrase(word: hireganaWord);
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
