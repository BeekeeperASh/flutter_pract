import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_pract/shared/service_locator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../shared/widgets/app_state_scope.dart';
import '../../app_state.dart';
import '../widgets/cart_item_tile.dart';
import '../../../shared/widgets/empty_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState appState;
    if (locator.isRegistered<AppState>()) {
      appState = locator.get<AppState>();
    } else {
      printToConsole('AppState не зарегистрирован, создание пустого состояния');
      appState = AppState();
    }
    final totalPrice = appState.cartTotal;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: appState.cartItems.isEmpty
                ? const EmptyState(
                    message: 'Ваша корзина пуста\nДобавьте товары из меню',
                    icon: Icons.shopping_cart_outlined,
                    imageUrl: '',
                  )
                : ListView.builder(
                    itemCount: appState.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = appState.cartItems[index];
                      return CartItemTile(
                        item: item,
                        onRemove: () => appState.removeFromCart(item.id),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Итого: $totalPrice ₽',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: appState.cartItems.isEmpty
                            ? null
                            : () => appState.clearCart(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        child: const Text('Очистить'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: appState.cartItems.isEmpty
                            ? null
                            : () => context.push('/menu/checkout'),
                        child: const Text('Оформить заказ'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
