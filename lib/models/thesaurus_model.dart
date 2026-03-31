class ThesaurusResult {
  final String word;
  final List<String> synonyms;
  final List<String> antonyms;
  final List<String> relatedPhrases;

  ThesaurusResult({
    required this.word,
    required this.synonyms,
    required this.antonyms,
    required this.relatedPhrases,
  });

  // Mock data for testing
  factory ThesaurusResult.mock(String word) {
    return ThesaurusResult(
      word: word,
      synonyms: ["reliable", "steadfast", "devoted", "constant"],
      antonyms: ["unfaithful", "disloyal", "fickle"],
      relatedPhrases: ["true to one's word", "keep the faith"],
    );
  }
}