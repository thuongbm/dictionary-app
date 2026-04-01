import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/navbar.dart';
import '../widgets/translation_card.dart';
import '../widgets/dictionary_display.dart';
import '../widgets/thesaurus_display.dart';
import '../providers/translation_provider.dart';
import '../providers/dictionary_provider.dart';
import '../providers/thesaurus_provider.dart';

// 1. IMPORT YOUR NEW SCREEN HERE
import 'translate_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _activeBottomTab = 'dictionary';
  
  // Track Top Navigation active tab
  String _currentNavTab = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Navbar
            Navbar(
              currentTab: _currentNavTab,
              onTabSelected: (selectedTab) {
                setState(() {
                  _currentNavTab = selectedTab; // This triggers the switch!
                });
              },
            ),
            
            // Render content based on which tab is clicked
            if (_currentNavTab == 'home') ...[
              // --- HOME VIEW ---
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 280,
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2962FF),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 60),
                        child: Text(
                          "Translate and explore the world's languages.",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: TranslationCard(),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _bottomBtn(
                          Icons.crop_landscape,
                          "Dictionary",
                          isOrange: _activeBottomTab == 'dictionary', 
                          onTap: () {
                            setState(() {
                              _activeBottomTab = 'dictionary';
                            });
                          },
                        ),
                        const SizedBox(width: 15),
                        _bottomBtn(
                          Icons.waves,
                          "Thesaurus",
                          isOrange: _activeBottomTab == 'thesaurus', 
                          onTap: () {
                            setState(() {
                              _activeBottomTab = 'thesaurus';
                            });
                            final word = context.read<TranslationProvider>().resultText;
                            if (word.isNotEmpty && word != "Hello") {
                               context.read<ThesaurusProvider>().searchThesaurus(word);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    if (_activeBottomTab == 'dictionary')
                      Consumer<DictionaryProvider>(
                        builder: (context, dictProvider, child) {
                          if (dictProvider.result == null && !dictProvider.isLoading) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: dictProvider.isLoading
                                ? const Center(child: CircularProgressIndicator())
                                : DictionaryDisplayWidget(data: dictProvider.result!),
                          );
                        },
                      )
                    else 
                      Consumer<ThesaurusProvider>(
                        builder: (context, thesProvider, child) {
                          if (thesProvider.result == null && !thesProvider.isLoading) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: thesProvider.isLoading
                                ? const Center(child: CircularProgressIndicator(color: Colors.blue))
                                : ThesaurusDisplayWidget(data: thesProvider.result!),
                          );
                        },
                      ),
                    
                    const SizedBox(height: 60),
                    Divider(color: Colors.grey[300]),
                  ],
                ),
              ),
            ] 
            
            // 2. SWITCH TO YOUR NEW SCREEN HERE
            else if (_currentNavTab == 'translate') ...[
              const TranslateScreen(), 
            ]
            
            // Fallback for other tabs (like Dictionary or Thesaurus on the top nav)
            else ...[
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(child: Text("$_currentNavTab page coming soon!")),
              )
            ]
          ],
        ),
      ),
    );
  }

  // Helper widget for bottom buttons
  Widget _bottomBtn(IconData icon, String label,
      {bool isOrange = false, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isOrange ? const Color(0xFFF4B459) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: isOrange ? null : Border.all(color: Colors.grey[300]!),
          boxShadow: [
            if (isOrange)
              BoxShadow(
                  color: Colors.orange.withValues(alpha: 0.3), blurRadius: 8)
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: isOrange ? Colors.white : Colors.black),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isOrange ? Colors.white : Colors.black)),
          ],
        ),
      ),
    );
  }
}