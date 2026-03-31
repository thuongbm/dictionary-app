import 'package:flutter/material.dart';
import '../models/word_model.dart';

class DictionaryDisplayWidget extends StatelessWidget {
  final DictionaryResult data;

  const DictionaryDisplayWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9), // Light grey background like the image
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Word + Speaker
          Row(
            children: [
              Text("Word", style: TextStyle(color: Colors.grey[600], fontSize: 16)),
              const SizedBox(width: 15),
              Text(data.word, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Icon(Icons.volume_up_outlined, color: Colors.grey[600], size: 20),
            ],
          ),
          const SizedBox(height: 20),
          
          // 3-Column Layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column 1: Word Detail
              Expanded(
                child: _buildInfoCard(
                  title: "Details",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Adjective", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(data.pronunciation, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              
              // Column 2: Definition(s)
              Expanded(
                child: _buildInfoCard(
                  title: "Definition(s)",
                  child: Column(
                    children: data.definitions.map((def) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(def.meaning, style: const TextStyle(height: 1.5)),
                    )).toList(),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              
              // Column 3: Related Words
              Expanded(
                child: _buildInfoCard(
                  title: "Related Words",
                  child: Column(
                    children: [
                      _relatedWordRow("Synonym", "example"),
                      _relatedWordRow("Synonym", "sample"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.description_outlined, size: 18, color: Colors.grey),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: child,
        ),
      ],
    );
  }

  Widget _relatedWordRow(String label, String word) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Text("• ", style: TextStyle(color: Colors.red)),
          Text("$word — ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}