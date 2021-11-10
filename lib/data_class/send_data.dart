class SendData {
  final String displayName;
  final String inputWord;
  final String userId;
  final String notice;
  final double matchDegrees;
  final String satisfactionDegrees;
  final String existing;
  final String notExistNegativeWord;

//<editor-fold desc="Data Methods">

  const SendData({
    required this.displayName,
    required this.inputWord,
    required this.userId,
    required this.notice,
    required this.matchDegrees,
    required this.satisfactionDegrees,
    required this.existing,
    required this.notExistNegativeWord,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SendData &&
          runtimeType == other.runtimeType &&
          displayName == other.displayName &&
          inputWord == other.inputWord &&
          userId == other.userId &&
          notice == other.notice &&
          matchDegrees == other.matchDegrees &&
          satisfactionDegrees == other.satisfactionDegrees &&
          existing == other.existing &&
          notExistNegativeWord == other.notExistNegativeWord);

  @override
  int get hashCode =>
      displayName.hashCode ^
      inputWord.hashCode ^
      userId.hashCode ^
      notice.hashCode ^
      matchDegrees.hashCode ^
      satisfactionDegrees.hashCode ^
      existing.hashCode ^
      notExistNegativeWord.hashCode;

  @override
  String toString() {
    return 'SendData{' +
        ' displayName: $displayName,' +
        ' inputWord: $inputWord,' +
        ' userId: $userId,' +
        ' notice: $notice,' +
        ' matchDegrees: $matchDegrees,' +
        ' satisfactionDegrees: $satisfactionDegrees,' +
        ' existing: $existing,' +
        ' notExistNegativeWord: $notExistNegativeWord,' +
        '}';
  }

  SendData copyWith({
    String? displayName,
    String? inputWord,
    String? userId,
    String? notice,
    double? matchDegrees,
    String? satisfactionDegrees,
    String? existing,
    String? notExistNegativeWord,
  }) {
    return SendData(
      displayName: displayName ?? this.displayName,
      inputWord: inputWord ?? this.inputWord,
      userId: userId ?? this.userId,
      notice: notice ?? this.notice,
      matchDegrees: matchDegrees ?? this.matchDegrees,
      satisfactionDegrees: satisfactionDegrees ?? this.satisfactionDegrees,
      existing: existing ?? this.existing,
      notExistNegativeWord: notExistNegativeWord ?? this.notExistNegativeWord,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': this.displayName,
      'inputWord': this.inputWord,
      'userId': this.userId,
      'notice': this.notice,
      'matchDegrees': this.matchDegrees,
      'satisfactionDegrees': this.satisfactionDegrees,
      'existing': this.existing,
      'notExistNegativeWord': this.notExistNegativeWord,
    };
  }

  factory SendData.fromMap(Map<String, dynamic> map) {
    return SendData(
      displayName: map['displayName'] as String,
      inputWord: map['inputWord'] as String,
      userId: map['userId'] as String,
      notice: map['notice'] as String,
      matchDegrees: map['matchDegrees'] as double,
      satisfactionDegrees: map['satisfactionDegrees'] as String,
      existing: map['existing'] as String,
      notExistNegativeWord: map['notExistNegativeWord'] as String,
    );
  }

//</editor-fold>
}