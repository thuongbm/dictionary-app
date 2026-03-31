import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'hover_builder.dart';
import '../providers/translation_provider.dart';
import '../providers/dictionary_provider.dart';
import '../providers/thesaurus_provider.dart'; 

class TranslationCard extends StatefulWidget {
  const TranslationCard({super.key});

  @override
  State<TranslationCard> createState() => _TranslationCardState();
}

class _TranslationCardState extends State<TranslationCard> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translationData = Provider.of<TranslationProvider>(context);
    final dictProvider = Provider.of<DictionaryProvider>(context);
    final thesaurusProvider = Provider.of<ThesaurusProvider>(context); 

    return Container(
      width: 1000,
      height: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              // LEFT PANE (From)
              _buildInputPane(
                label: "From:",
                lang: "Tiếng Việt",
                controller: _inputController,
                onSubmitted: (val) async {
                  // --- UPDATED LOGIC ---
                  // 1. Translate the text
                  await translationData.handleTranslation(val);
                  
                  // 2. ONLY search the Dictionary automatically
                  if (mounted) {
                    final result = translationData.resultText;
                    context.read<DictionaryProvider>().searchWord(result);
                    
                    // Thesaurus auto-trigger REMOVED from here 
                    // to prevent it from showing up until the button is clicked.
                  }
                },
                hasMic: true,
              ),
              
              VerticalDivider(width: 1, thickness: 1, color: Colors.grey[300]),
              
              // RIGHT PANE (To)
              _buildResultPane(
                label: "To:",
                lang: "English",
                result: translationData.resultText,
                isLoading: translationData.isLoading,
                onSeeMore: () {
                  // Manual trigger: If they click "See Details", show both.
                  final result = translationData.resultText;
                  dictProvider.searchWord(result);
                  thesaurusProvider.searchThesaurus(result);
                },
              ),
            ],
          ),
          
          _swapButton(),
        ],
      ),
    );
  }

  // --- HELPER METHODS ---

  Widget _buildInputPane({
    required String label,
    required String lang,
    required TextEditingController controller,
    required Function(String) onSubmitted,
    bool hasMic = false,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _langHeader(label, lang),
            const SizedBox(height: 30),
            TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w400),
              decoration: const InputDecoration(
                hintText: "Nhập văn bản...",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const Spacer(),
            _actionIcons(hasMic),
          ],
        ),
      ),
    );
  }

  Widget _buildResultPane({
    required String label,
    required String lang,
    required String result,
    required bool isLoading,
    required VoidCallback onSeeMore,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _langHeader(label, lang),
            const SizedBox(height: 30),
            isLoading 
                ? const Center(child: CircularProgressIndicator()) 
                : Text(result, style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w400)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _actionIcons(false),
                if (result.isNotEmpty && result != "Hello") 
                  TextButton(
                    onPressed: onSeeMore,
                    child: const Text(
                      "See Details",
                      style: TextStyle(color: Color(0xFFB04B3A), fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _langHeader(String label, String lang) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(width: 8),
        Text(lang, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
      ],
    );
  }

  Widget _actionIcons(bool hasMic) {
    return Row(
      children: [
        if (hasMic) _actionIcon(Icons.mic_none),
        if (hasMic) const SizedBox(width: 15),
        _actionIcon(Icons.copy),
        const SizedBox(width: 15),
        _actionIcon(Icons.volume_up_outlined),
      ],
    );
  }

  Widget _actionIcon(IconData icon) {
    return HoverBuilder(
      builder: (isHovered) => Icon(
        icon,
        color: isHovered ? Colors.blue : Colors.grey[600],
        size: 22,
      ),
    );
  }

  Widget _swapButton() {
    return HoverBuilder(
      builder: (isHovered) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isHovered ? Colors.blue[700] : Colors.black,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.swap_horiz, color: Colors.white, size: 20),
      ),
    );
  }
}