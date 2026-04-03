import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dictionary_provider.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _submitSearch() {
    if (_searchController.text.trim().isNotEmpty) {
      // **NOTE:** Change 'searchWord' to whatever method your provider uses to fetch data
      context.read<DictionaryProvider>().searchWord(_searchController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Search Bar
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (_) => _submitSearch(),
                    decoration: const InputDecoration(
                      hintText: "Search English",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black87, size: 20),
                  onPressed: _submitSearch,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 50),

          // Dictionary Result Display
          Consumer<DictionaryProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (provider.result == null) {
                return const Center(
                  child: Text("Search for a word to see its definition.", style: TextStyle(color: Colors.grey)),
                );
              }

              final data = provider.result!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Word Title
                  Text(
                    data.word,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Part of speech (e.g., adjective, adverb, exclamation)
                  // Assuming your model has a way to get these. If it's a list, join them.
                  const Text(
                    "adjective, adverb, exclamation", // Replace with real data: data.partOfSpeech
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Pronunciation & Speaker
                  Row(
                    children: [
                      const Text(
                        "US",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.volume_up_outlined, size: 18),
                        onPressed: () {
                          // Trigger audio playback here if you have it
                        },
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 15),
                  const Divider(color: Colors.grey, thickness: 1),
                  
                  // You can map over definitions here below the divider later!
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}