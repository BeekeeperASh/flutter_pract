import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../widgets/cart_item_tile.dart';
import '../../../shared/widgets/empty_state.dart';

class CartScreen extends StatelessWidget {
  final List<CartItem> cartItems;
  final ValueChanged<String> onRemoveFromCart;
  final VoidCallback onClearCart;
  final VoidCallback onCheckout;
  final VoidCallback onShowMenu;
  final VoidCallback onShowOrders;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onRemoveFromCart,
    required this.onClearCart,
    required this.onCheckout,
    required this.onShowMenu,
    required this.onShowOrders,
  });

  double get _totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onShowMenu,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: onShowOrders,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const EmptyState(
              message: 'Ваша корзина пуста\nДобавьте товары из меню',
              imageUrl: 'https://avatars.mds.yandex.net/i?id=2d6069aadfe5cb3e964684cbbb33acc34342f19a-5810594-images-thumbs&n=13',
              icon: Icons.shopping_cart_outlined,
            )
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CartItemTile(
                  item: item,
                  onRemove: () => onRemoveFromCart(item.id),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Итого: ${_totalPrice.toInt()} ₽',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: cartItems.isEmpty ? null : onClearCart,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                        child: const Text('Очистить'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: cartItems.isEmpty ? null : onCheckout,
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