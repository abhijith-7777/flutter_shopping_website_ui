import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/cart_button.dart';

final ordersProvider = StateNotifierProvider<OrdersNotifier, Map<Item, int>>(
  (ref) => OrdersNotifier(),
);

class OrdersNotifier extends StateNotifier<Map<Item, int>> {
  OrdersNotifier() : super({});

  void addOrders(Map<Item, int> newOrders) {
    final updatedOrders = Map<Item, int>.from(state);
    newOrders.forEach((item, quantity) {
      if (updatedOrders.containsKey(item)) {
        updatedOrders[item] = updatedOrders[item]! + quantity;
      } else {
        updatedOrders[item] = quantity;
      }
    });
    state = updatedOrders;
  }

  void cancelOrder(Item item) {
    final updatedOrders = Map<Item, int>.from(state);
    if (updatedOrders.containsKey(item)) {
      updatedOrders.remove(item);
      state = updatedOrders;
    }
  }
}
