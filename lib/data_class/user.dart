class User {
  final String userId;
  final String displayName;
  final String inputWord;
  final String selectedWord;
  final String positiveDegrees;
  final String isMatched;

//<editor-fold desc="Data Methods">

  const User({
    required this.userId,
    required this.displayName,
    required this.inputWord,
    required this.selectedWord,
    required this.positiveDegrees,
    required this.isMatched,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          inputWord == other.inputWord &&
          selectedWord == other.selectedWord &&
          positiveDegrees == other.positiveDegrees &&
          isMatched == other.isMatched);

  @override
  int get hashCode =>
      userId.hashCode ^
      displayName.hashCode ^
      inputWord.hashCode ^
      selectedWord.hashCode ^
      positiveDegrees.hashCode ^
      isMatched.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' userId: $userId,' +
        ' displayName: $displayName,' +
        ' inputWord: $inputWord,' +
        ' selectedWord: $selectedWord,' +
        ' positiveDegrees: $positiveDegrees,' +
        ' isMatched: $isMatched,' +
        '}';
  }

  User copyWith({
    String? userId,
    String? displayName,
    String? inputWord,
    String? selectedWord,
    String? positiveDegrees,
    String? isMatched,
  }) {
    return User(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      inputWord: inputWord ?? this.inputWord,
      selectedWord: selectedWord ?? this.selectedWord,
      positiveDegrees: positiveDegrees ?? this.positiveDegrees,
      isMatched: isMatched ?? this.isMatched,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'displayName': this.displayName,
      'inputWord': this.inputWord,
      'selectedWord': this.selectedWord,
      'positiveDegrees': this.positiveDegrees,
      'isMatched': this.isMatched,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      displayName: map['displayName'] as String,
      inputWord: map['inputWord'] as String,
      selectedWord: map['selectedWord'] as String,
      positiveDegrees: map['positiveDegrees'] as String,
      isMatched: map['isMatched'] as String,
    );
  }

//</editor-fold>
}