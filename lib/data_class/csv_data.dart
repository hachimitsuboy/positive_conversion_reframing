class CsvData {
  final String kanji;
  final String hiragana;
  final String paraphraseWordA;
  final String? paraphraseWordB;
  final String? paraphraseWordC;

  CsvData({
    required this.kanji,
    required this.hiragana,
    required this.paraphraseWordA,
    this.paraphraseWordB,
    this.paraphraseWordC,
  });
}
