import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final VoidCallback onSearchTap;

  const MyAppBar({super.key, required this.onSearchTap});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  

    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text("🛍️", style: TextStyle(fontSize: 20, color: Colors.white)),
          SizedBox(width: 8),
          Text(
            "Ajio",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
        ],
      ),
      centerTitle: false,
      backgroundColor: const Color.fromARGB(255, 102, 98, 144),
      elevation: 4,
      shadowColor: Colors.black45,
    
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
      ),
    );
  }
}
