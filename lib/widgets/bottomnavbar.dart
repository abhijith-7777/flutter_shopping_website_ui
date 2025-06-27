import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/cart_button.dart';
import '../providers/home_screen_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static final List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Favorites Page'),
    Text('Cart Page'),
    
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    void onItemTapped(int index) {
      ref.read(selectedIndexProvider.notifier).state = index;
    }

    return Scaffold(
      body: _widgetOptions[selectedIndex],
      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}

class MyBottomNavBar extends ConsumerWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const MyBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartCount = cartItems.length;

    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 237, 235, 235),
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: CartButton(
            count: cartCount,
            onPressed: () {
              onTap(2);
            },
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
    );
  }
}
