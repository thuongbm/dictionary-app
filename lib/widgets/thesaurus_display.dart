import 'package:flutter/material.dart';
import '../models/thesaurus_model.dart';

class ThesaurusDisplayWidget extends StatelessWidget {
  final ThesaurusResult data;

  const ThesaurusDisplayWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Nếu không đủ chỗ (dưới 600px), chuyển sang xếp dọc (Vertical)
        bool useVertical = constraints.maxWidth < 600;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4FF),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.waves, color: Colors.blue),
                  SizedBox(width: 10),
                  Text("Thesaurus", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 25),
              
              // THAY ĐỔI QUAN TRỌNG TẠI ĐÂY
              Flex(
                direction: useVertical ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Synonyms
                  useVertical ? _buildCategory("Synonyms", data.synonyms, Colors.green)
                            : Expanded(child: _buildCategory("Synonyms", data.synonyms, Colors.green)),
                  
                  SizedBox(width: useVertical ? 0 : 20, height: useVertical ? 25 : 0),
                  
                  // Antonyms
                  useVertical ? _buildCategory("Antonyms", data.antonyms, Colors.red)
                            : Expanded(child: _buildCategory("Antonyms", data.antonyms, Colors.red)),
                ],
              ),
            ],
          ),
        );
      }
    );
  }

  // Change 'Color color' to 'MaterialColor color'
  // Ensure this says 'MaterialColor color' instead of just 'Color color'
  Widget _buildCategory(String title, List<String> words, MaterialColor color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: words.map((w) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              // Use withValues for the new Flutter version
              border: Border.all(color: color.withValues(alpha: 0.3)), 
            ),
            // This [700] now works because the type is MaterialColor
            child: Text(w, style: TextStyle(color: color[700], fontWeight: FontWeight.w500)),
          )).toList(),
        ),
      ],
    );
  }
}