import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/app_bar.dart';
import '../widgets/item_tile.dart';
import '../widgets/bottomnavbar.dart';
import '../widgets/cart_button.dart';
import 'profile_screen.dart';
import '../providers/home_screen_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedItems = ref.watch(likedItemsProvider);
    final selectedIndex = ref.watch(selectedIndexProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    Widget bodyContent;
    if (selectedIndex == 0) {
      final filteredItems = searchQuery.isEmpty
          ? items
          : items.where((item) => item.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();

      bodyContent = Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
              decoration: InputDecoration(
                hintText: 'Search items...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) => ItemTile(item: filteredItems[index]),
            ),
          ),
        ],
      );
    } else if (selectedIndex == 1) {
      bodyContent = likedItems.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemCount: likedItems.length,
              itemBuilder: (context, index) =>
                  ItemTile(item: likedItems.elementAt(index)),
            );
    } else if (selectedIndex == 2) {
      bodyContent = const CartScreen();
    } else if (selectedIndex == 3) {
      bodyContent = const ProfileScreen();
    } else {
      bodyContent = Container();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: MyAppBar(onSearchTap: () {}),
      ),
      body: bodyContent,
      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: selectedIndex,
        onTap: (index) => ref.read(selectedIndexProvider.notifier).state = index,
      ),
    );
  }
}
