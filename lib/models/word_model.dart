class DictionaryResult {
  final String word;
  final String pronunciation;
  final List<Definition> definitions;
  final List<String> grammarTips;

  DictionaryResult({
    required this.word,
    required this.pronunciation,
    required this.definitions,
    required this.grammarTips,
  });

  factory DictionaryResult.fromJson(Map<String, dynamic> json) {
    return DictionaryResult(
      word: json['word'] ?? '',
      // Map 'phonetic' from Flask to 'pronunciation'
      pronunciation: json['phonetic'] ?? '', 
      // Map 'meanings' from Flask to 'definitions'
      definitions: (json['meanings'] as List?)
              ?.map((d) => Definition.fromJson(d))
              .toList() ?? [],
      grammarTips: [], // Flask doesn't provide this yet
    );
  }
}

class Definition {
  final String partOfSpeech;
  final String meaning;
  final String example;

  Definition({
    required this.partOfSpeech,
    required this.meaning,
    required this.example,
  });

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(
      // Map 'pos' from Flask to 'partOfSpeech'
      partOfSpeech: json['pos'] ?? '', 
      meaning: json['meaning'] ?? '',
      example: json['example'] ?? '',
    );
  }
}