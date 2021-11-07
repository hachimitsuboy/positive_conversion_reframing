import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:positive_conversion_reframing/data_class/csv_data.dart';
import 'package:http/http.dart' as http;

class ReframingViewModel extends ChangeNotifier {
  bool isLoading = false;
  bool isSuccess = false;
  late String blankDeletingWord;

  CsvData? csvData;

  Future<void> getParaphrase({required String word}) async {
    //初期化処理
    csvData = null;
    print("getParaphrase: $word / ${word.length}");

    //文字に入る空白を削除
    blankDeletingWord = word.replaceAll(RegExp(r'\s'), '');
    print(
        "blankDeletingWord: $blankDeletingWord / ${blankDeletingWord.length}");

    final String csv = await rootBundle.loadString("assets/csv/reframing.csv");
    //1.csvファイルを改行ごとに区切って、区切った文字列をcsvDataListの要素として追加
    //ex)csvDataList[0] = 飽きっぽい,あきっぽい,素直従順,環境に馴染みやすい,好奇心旺盛な
    List<String> csvDataList = csv.split("\n");

    //2.csvDataListの各要素において,","によって区切ることで新たにString型のListを作成する
    //平仮名変換された入力された単語とこの時作られたListの2番目の要素と一致するCsvDataクラスを取得する
    //ループを回り終わった後（一致するものがなかった場合）、csvDataには何も入らない
    csvDataList.forEach((element) {
      final rowData = element.split(",");
      final CsvData matchCsvData = CsvData(
        kanji: rowData[0],
        hiragana: rowData[1],
        paraphraseWordA: rowData[2],
        paraphraseWordB: rowData[3],
        paraphraseWordC: rowData[4],
      );
      print(
          "matchCsvData: ${matchCsvData.hiragana} / blankDeletingWord: $blankDeletingWord");
      if (matchCsvData.hiragana.contains(blankDeletingWord)) {
        csvData = matchCsvData;
        //TODO break処理（forEachだとbreakが使えないみたい）
      }
    });

    if (csvData != null) {
      print("一致するCsvDataが存在しました: ${csvData!.hiragana}");
      print("入力した単語: ${csvData}");
      print(
          "ポジティブ変換後: ${csvData!.paraphraseWordA} / ${csvData!.paraphraseWordB ?? ""} / ${csvData!.paraphraseWordC ?? ""}");

      isSuccess = true;
    } else {
      print("一致するCsvDataが存在しませんでした: ${csvData}");

      isSuccess = false;
    }

    isLoading = true;
    notifyListeners();
  }

  Future<String> convertToHiragana({required String enteredWord}) async {
    final data = enteredWord;
    final urlString = "https://labs.goo.ne.jp/api/hiragana";
    final uri = Uri.parse(urlString);
    final headers = {"content-type": "application/json"};
    final body = {
      "app_id":
          "86150de65e763b32e3c18dd66045195187220aa4d2c5064703b846e8c84e77a8",
      "sentence": "$data",
      "output_type": "hiragana"
    };

    final res = await http.post(uri, headers: headers, body: jsonEncode(body));
    // print(res.body);
    var resultBody = json.decode(res.body);
    var enteredHiraganaWord = resultBody["converted"];
    print("かな変換後: $enteredHiraganaWord");

    return enteredHiraganaWord;
  }
}
