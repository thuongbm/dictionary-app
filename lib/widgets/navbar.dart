import 'package:flutter/material.dart';
// 1. MAKE SURE THIS IMPORT MATCHES YOUR FILE NAME
import 'hover_builder.dart'; 

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          // Logo
          const Text(
            "N3Dictionary",
            style: TextStyle(
              color: Color(0xFFB04B3A),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          // Menu Items
          _navItem(Icons.home, "Home", isSelected: true),
          _navItem(Icons.crop_landscape, "Dictionary"),
          _navItem(Icons.translate, "Translate"),
          _navItem(Icons.waves, "Thesaurus"),
          const Spacer(),
          // Language & Profile
          const Row(
            children: [
              Icon(Icons.language, size: 18),
              SizedBox(width: 5),
              Text("English(US)"),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
          const SizedBox(width: 20),
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.person, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // 2. MOVED INSIDE THE CLASS & REMOVED THE 'transition' ERROR
  Widget _navItem(IconData icon, String label, {bool isSelected = false}) {
    return HoverBuilder(
      builder: (isHovered) {
        Color contentColor = isSelected
            ? Colors.red[400]!
            : (isHovered ? Colors.blue : Colors.black87);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Icon(icon, size: 20, color: contentColor),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: contentColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  // 'transition' was removed because it's not a valid property here
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}