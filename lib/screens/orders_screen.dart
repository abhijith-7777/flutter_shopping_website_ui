import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/orders_provider.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    if (orders.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
        ),
        body: const Center(
          child: Text(
            'No Orders.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final item = orders.keys.elementAt(index);
          final quantity = orders[item] ?? 0;
          final totalPrice = item.price * quantity;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row with Image and Text
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        item.imagePath,
                        width: 50,
                        height: 50,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('\$${item.price} Qty: $quantity'),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Total Price
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Total: \$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Delivery Info
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: const Text(
                      'Delivery Tomorrow',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Cancel Button
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Cancel Order'),
                              content: const Text('Are you sure you want to cancel this order?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ref.read(ordersProvider.notifier).cancelOrder(item);
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 178, 177, 177),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

