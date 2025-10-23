import 'package:cached_network_image/cached_network_image.dart';
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
    const String imageUrl =
        'https://avatars.mds.yandex.net/i?id=ab4718d6476dc013e0e09659db0b047f0ba3cc04-5337260-images-thumbs&n=13';
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
          ? Center(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                progressIndicatorBuilder: (context, url, error) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => CircleAvatar(
                  backgroundColor: Colors.pink.shade100,
                  child: const Icon(Icons.cake, color: Colors.pink),
                ),
              ),
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
