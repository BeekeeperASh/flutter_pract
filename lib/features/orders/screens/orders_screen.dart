import 'package:flutter/material.dart';
import '../models/order.dart';
import '../widgets/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  final List<Order> orders;
  final VoidCallback onShowMenu;
  final VoidCallback onShowCart;

  const OrdersScreen({
    super.key,
    required this.orders,
    required this.onShowMenu,
    required this.onShowCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои заказы'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onShowMenu,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: onShowCart,
          ),
        ],
      ),
      body: orders.isEmpty
          ? const Center(child: Text('История заказов пуста'))
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return OrderTile(order: order);
        },
      ),
    );
  }
}