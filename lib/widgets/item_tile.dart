import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cart_button.dart';

import 'animated_logo.dart';

final List<Item> items = const [
  Item(
    name: "Blackshirt",
    price: 299,
    imagePath: "assets/images/img1.jpg",
    rating: 3.5,
  ),
  Item(
    name: "Pant",
    price: 199,
    imagePath: "assets/images/img2.jpg",
    rating: 4.0,
  ),
  Item(
    name: "Whiteshirt",
    price: 399,
    imagePath: "assets/images/img3.jpg",
    rating: 1.8,
  ),
  Item(
    name: "Whiteshirt",
    price: 499,
    imagePath: "assets/images/img4.jpg",
    rating: 4.2,
  ),
  Item(
    name: "Pant",
    price: 599,
    imagePath: "assets/images/img5.jpg",
    rating: 4.3,
  ),
  Item(
    name: "Blueshirt",
    price: 499,
    imagePath: "assets/images/img6.jpg",
    rating: 4.7,
  ),
  Item(
    name: "Jacket",
    price: 899,
    imagePath: "assets/images/img7.jpg",
    rating: 2.9,
  ),
  Item(
    name: "Blueshoe",
    price: 599,
    imagePath: "assets/images/img8.jpg",
    rating: 5,
  ),
];

final likedItemsProvider = StateNotifierProvider<LikedItemsNotifier, Set<Item>>(
  (ref) => LikedItemsNotifier(),
);

class LikedItemsNotifier extends StateNotifier<Set<Item>> {
  LikedItemsNotifier() : super({});

  void toggleLike(Item item) {
    if (state.contains(item)) {
      state = Set.from(state)..remove(item);
    } else {
      state = Set.from(state)..add(item);
    }
  }
}

class ItemTile extends ConsumerStatefulWidget {
  final Item item;
  const ItemTile({super.key, required this.item});

  @override
  ConsumerState<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends ConsumerState<ItemTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showHearts = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _showHearts = false);
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onFavoritePressed() {
    ref.read(likedItemsProvider.notifier).toggleLike(widget.item);
    setState(() => _showHearts = true);
    _controller.forward();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ref.read(likedItemsProvider).contains(widget.item)
              ? "Added to favorites"
              : "Removed from favorites",
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLiked = ref.watch(likedItemsProvider).contains(widget.item);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.item.imagePath,
                      width: double.infinity,

                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 60),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.item.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < widget.item.rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            size: 16,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${widget.item.price.toStringAsFixed(0)}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(cartProvider.notifier)
                                  .addToCart(widget.item);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                233,
                                229,
                                229,
                              ),
                            ),
                            child: const Text(
                              "Buy",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(cartProvider.notifier)
                                  .addToCart(widget.item);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "${widget.item.name} added to cart",
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                233,
                                229,
                                229,
                              ),
                            ),
                            child: const Text(
                              "Add",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          HeartBurstAnimation(animation: _controller, show: _showHearts),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(0),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.grey,
                ),
                onPressed: _onFavoritePressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
