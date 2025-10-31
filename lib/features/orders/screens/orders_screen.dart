import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../shared/widgets/empty_state.dart';
import '../models/order.dart';
import '../widgets/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  final List<Order> orders;

  const OrdersScreen({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои заказы'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: orders.isEmpty
          ? const EmptyState(
        message: 'У вас еще нет заказов\nОформите первый заказ в корзине',
        icon: Icons.receipt_long, imageUrl: '',
      )
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
