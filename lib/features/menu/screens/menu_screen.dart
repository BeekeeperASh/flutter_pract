import 'package:cached_network_image/cached_network_image.dart';
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
    const String imageUrl =
        'https://avatars.mds.yandex.net/i?id=3fa346cfb097bdaa65ac3c8c1104a27a_l-5367991-images-thumbs&n=13';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sweet Delights'),
        leading: CachedNetworkImage(
          imageUrl: imageUrl,
          progressIndicatorBuilder: (context, url, error) =>
              const CircularProgressIndicator(),
          errorWidget: (context, url, error) => CircleAvatar(
            backgroundColor: Colors.pink.shade100,
            child: const Icon(Icons.cake, color: Colors.pink),
          ),
        ),
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
          IconButton(icon: const Icon(Icons.history), onPressed: onShowOrders),
        ],
      ),
      body: menuItems.isEmpty
          ? const EmptyState(
              message: 'Меню временно недоступно',
              imageUrl: '',
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
