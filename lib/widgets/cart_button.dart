import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/orders_provider.dart';

final cartProvider = StateNotifierProvider<CartNotifier, Map<Item, int>>(
  (ref) => CartNotifier(),
);

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    double overallTotal = 0;
    cartItems.forEach((item, quantity) {
      overallTotal += item.price * quantity;
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: cartItems.isEmpty
          ? const Center(child: Text('No items in the cart.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems.keys.elementAt(index);
                      final quantity = cartItems[item] ?? 0;
                      final totalPrice = item.price * quantity;
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    item.imagePath,
                                    width: 50,
                                    height: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  final cartNotifier = ref.read(
                                                    cartProvider.notifier,
                                                  );
                                                  cartNotifier.decrement(item);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                        255,
                                                        193,
                                                        189,
                                                        189,
                                                      ),
                                                  minimumSize: const Size(
                                                    20,
                                                    20,
                                                  ),
                                                  padding: EdgeInsets.zero,
                                                ),
                                                child: const Icon(Icons.remove),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                    ),
                                                child: Text('Qty: $quantity'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  final cartNotifier = ref.read(
                                                    cartProvider.notifier,
                                                  );
                                                  cartNotifier.addToCart(item);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                        255,
                                                        178,
                                                        185,
                                                        179,
                                                      ),
                                                  minimumSize: const Size(
                                                    20,
                                                    20,
                                                  ),
                                                  padding: EdgeInsets.zero,
                                                ),
                                                child: const Icon(Icons.add),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        final cartNotifier = ref.read(
                                          cartProvider.notifier,
                                        );
                                        cartNotifier.removeItem(item);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          212,
                                          204,
                                          203,
                                        ),
                                      ),
                                      child: const Text('Remove'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Ordered ${item.name}',
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                            255,
                                            163,
                                            167,
                                            163,
                                          ),
                                        ),
                                        child: const Text('Order'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(text: 'Total: '),
                              TextSpan(
                                text: '\$${overallTotal.toStringAsFixed(2)}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            final cartNotifier = ref.read(
                              cartProvider.notifier,
                            );
                            final ordersNotifier = ref.read(
                              ordersProvider.notifier,
                            );
                            final currentCart = cartItems;
                            if (currentCart.isNotEmpty) {
                              ordersNotifier.addOrders(currentCart);
                              cartNotifier.clearCart();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Order placed for total amount: \$${overallTotal.toStringAsFixed(2)}',
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              255,
                              196,
                              0,
                            ),
                          ),
                          child: const Text('Place Order'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class CartNotifier extends StateNotifier<Map<Item, int>> {
  CartNotifier() : super({});

  void addToCart(Item item) {
    if (state.containsKey(item)) {
      state = {...state, item: state[item]! + 1};
    } else {
      state = {...state, item: 1};
    }
  }

  void decrement(Item item) {
    if (!state.containsKey(item)) return;
    final currentQty = state[item]!;
    if (currentQty > 1) {
      state = {...state, item: currentQty - 1};
    } else {
      final newState = Map<Item, int>.from(state);
      newState.remove(item);
      state = newState;
    }
  }

  void removeItem(Item item) {
    if (!state.containsKey(item)) return;
    final newState = Map<Item, int>.from(state);
    newState.remove(item);
    state = newState;
  }

  void clearCart() {
    state = {};
  }

  int get count {
    int total = 0;
    for (final quantity in state.values) {
      total += quantity;
    }
    return total;
  }
}

class Item {
  final String name;
  final double price;
  final String imagePath;
  final double rating;

  const Item({
    required this.name,
    required this.price,
    required this.imagePath,
    this.rating = 4.0,
  });
}

class CartButton extends StatelessWidget {
  final int count;
  final VoidCallback? onPressed;
  const CartButton({super.key, required this.count, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
            padding: EdgeInsets.zero,
            iconSize: 24,
            icon: const Icon(Icons.shopping_cart),
            onPressed: null,
          ),
        ),
        if (count > 0)
          Positioned(
            right: 0,
            top: 0,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child: Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 189, 82, 82),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
