import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dictionary_provider.dart';
import '../models/word_model.dart'; // Make sure this is imported!

class DictionaryModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dictProvider = Provider.of<DictionaryProvider>(context);

    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView( // Add scroll in case definitions are long
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              onSubmitted: (val) => dictProvider.searchWord(val),
              decoration: InputDecoration(
                hintText: "Search dictionary...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 30),
            
            // Result Section
            if (dictProvider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (dictProvider.result != null)
              buildDictionaryDetail(dictProvider.result!) // Use the detailed version
            else
              const Center(child: Text("Type a word and press Enter")),
          ],
        ),
      ),
    );
  }

  // This is the detailed UI matching your Database schema
  Widget buildDictionaryDetail(DictionaryResult data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(data.word, style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Color(0xFFB04B3A))),
            const SizedBox(width: 15),
            Text(data.pronunciation, style: const TextStyle(fontSize: 20, color: Colors.blueGrey)),
            IconButton(icon: const Icon(Icons.volume_up), onPressed: () {}),
          ],
        ),
        const Divider(height: 40),
        const Text("Definitions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...data.definitions.map((def) => Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(5)),
                child: Text(def.partOfSpeech, style: TextStyle(color: Colors.blue[800], fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              Text(def.meaning, style: const TextStyle(fontSize: 16, height: 1.4)),
              const SizedBox(height: 8),
              Text("Example: \"${def.example}\"", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[600])),
            ],
          ),
        )).toList(),
      ],
    );
  }
}