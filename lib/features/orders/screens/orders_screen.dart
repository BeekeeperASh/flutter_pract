import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';
import '../widgets/order_tile.dart';
import '../../../shared/widgets/empty_state.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои заказы'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: appState.orders.isEmpty
          ? const EmptyState(
        message: 'У вас еще нет заказов\nОформите первый заказ в корзине',
        icon: Icons.receipt_long, imageUrl: '',
      )
          : ListView.builder(
        itemCount: appState.orders.length,
        itemBuilder: (context, index) {
          final order = appState.orders[index];
          return OrderTile(order: order);
        },
      ),
    );
  }
}