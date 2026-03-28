import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/translation_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // Blue background section
                Container(
                  height: 280,
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF2962FF), // Vibrant Blue
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Text(
                        "Translate and explore the world's languages.",
                        style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                // Overlapping Card
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: TranslationCard(),
                ),
              ],
            ),
            // Bottom Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
              child: Column(
                children: [
                  Row(
                    children: [
                      _bottomBtn(Icons.crop_landscape, "Dictionary", isOrange: true),
                      SizedBox(width: 15),
                      _bottomBtn(Icons.waves, "Thesaurus"),
                    ],
                  ),
                  SizedBox(height: 40),
                  Divider(color: Colors.grey[300]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Inside home_screen.dart

  Widget _bottomBtn(IconData icon, String label, {bool isOrange = false}) {
    return InkWell(
      onTap: () {}, // Essential: InkWell needs onTap to show effects
      borderRadius: BorderRadius.circular(15),
      child: Ink( // Use Ink instead of Container for decorations with InkWell
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isOrange ? Color(0xFFF4B459) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: isOrange ? null : Border.all(color: Colors.grey[300]!),
          boxShadow: [
            if (isOrange) BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 8)
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: isOrange ? Colors.white : Colors.black),
            SizedBox(width: 8),
            Text(
              label, 
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isOrange ? Colors.white : Colors.black
              )
            ),
          ],
        ),
      ),
    );
  }
}