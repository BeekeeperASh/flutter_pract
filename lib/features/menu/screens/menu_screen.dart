import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../widgets/menu_item_tile.dart';
import '../../cart/models/cart_item.dart';
import '../../../shared/widgets/empty_state.dart';

class MenuScreen extends StatelessWidget {
  final List<MenuItem> menuItems;
  final List<CartItem> cartItems;
  final ValueChanged<MenuItem> onAddToCart;
  final VoidCallback onShowCart;
  final VoidCallback onShowOrders;

  const MenuScreen({
    super.key,
    required this.menuItems,
    required this.cartItems,
    required this.onAddToCart,
    required this.onShowCart,
    required this.onShowOrders,
  });

  int get _totalCartItemsCount {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sweet Delights'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: onShowCart,
              ),
              if (_totalCartItemsCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    radius: 8,
                    child: Text(
                      _totalCartItemsCount.toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: onShowOrders,
          ),
        ],
      ),
      body: menuItems.isEmpty
          ? const EmptyState(
        message: 'Меню временно недоступно',
        icon: Icons.cake,
      )
          : ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return MenuItemTile(
            item: item,
            onAddToCart: () => onAddToCart(item),
          );
        },
      ),
    );
  }
}