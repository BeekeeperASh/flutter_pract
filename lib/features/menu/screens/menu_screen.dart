import 'package:flutter/material.dart';
import '../../cart/screens/cart_screen.dart';
import '../../cart/screens/checkout_screen.dart';
import '../../orders/models/order.dart';
import '../../orders/screens/orders_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../models/menu_item.dart';
import '../widgets/menu_item_tile.dart';
import '../../cart/models/cart_item.dart';
import '../../../shared/widgets/empty_state.dart';

class MenuScreen extends StatelessWidget {
  final List<MenuItem> menuItems;
  final List<CartItem> cartItems;
  final List<Order> orders;
  final ValueChanged<MenuItem> onAddToCart;
  final ValueChanged<String> onRemoveFromCart;
  final VoidCallback onClearCart;
  final ValueChanged<String> onUpdateOrderComment;
  final VoidCallback onCheckout;
  final String orderComment;

  const MenuScreen({
    super.key,
    required this.menuItems,
    required this.cartItems,
    required this.orders,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.onClearCart,
    required this.onUpdateOrderComment,
    required this.onCheckout,
    required this.orderComment,
  });

  int get _totalCartItemsCount {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void _navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          cartItems: cartItems,
          onRemoveFromCart: onRemoveFromCart,
          onClearCart: onClearCart,
          onCheckout: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutScreen(
                  cartItems: cartItems,
                  total: cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity)),
                  comment: orderComment,
                  onCommentChanged: onUpdateOrderComment,
                  onConfirm: () {
                    onCheckout();
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => OrdersScreen(orders: orders),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Заказ оформлен! Спасибо!')),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToOrders(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrdersScreen(
          orders: orders,
        ),
      ),
    );
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const ProfileScreen(),
      ),
    );
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
                onPressed: () => _navigateToCart(context),
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
            onPressed: () => _navigateToOrders(context),
          ),
        ],
      ),
      body: menuItems.isEmpty
          ? const EmptyState(
        message: 'Меню временно недоступно',
        icon: Icons.cake, imageUrl: '',
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const ProfileScreen(),
                ),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Меню',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
