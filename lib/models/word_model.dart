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

  // This is the "Mock" data for testing until your backend is ready
  factory DictionaryResult.mock(String word) {
    return DictionaryResult(
      word: word,
      pronunciation: "/${word.toLowerCase()}/",
      definitions: [
        Definition(
          partOfSpeech: "Noun",
          meaning: "This is a sample definition for '$word' from your database.",
          example: "Here is an example sentence using the word '$word'.",
        )
      ],
      grammarTips: ["Sample grammar tip for this word."],
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
}