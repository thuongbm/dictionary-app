class TranslationResult {
  final String translatedText;
  final String sourceLanguage;
  final String targetLanguage;

  TranslationResult({
    required this.translatedText,
    required this.sourceLanguage,
    required this.targetLanguage,
  });

  // This "factory" takes a JSON map from the backend and creates the object
  factory TranslationResult.fromJson(Map<String, dynamic> json) {
    return TranslationResult(
      translatedText: json['translatedText'] ?? '',
      sourceLanguage: json['source'] ?? 'Unknown',
      targetLanguage: json['target'] ?? 'Unknown',
    );
  }
}