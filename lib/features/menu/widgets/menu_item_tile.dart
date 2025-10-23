import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuItemTile extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onAddToCart;

  const MenuItemTile({
    super.key,
    required this.item,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: item.imageAsset,
          progressIndicatorBuilder: (context, url, error) =>
              const CircularProgressIndicator(),
          errorWidget: (context, url, error) => CircleAvatar(
            backgroundColor: Colors.pink.shade100,
            child: const Icon(Icons.cake, color: Colors.pink),
          ),
        ),
        title: Text(item.title),
        subtitle: Text(item.description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${item.price.toInt()} ₽',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: onAddToCart,
              child: const Text('В корзину'),
            ),
          ],
        ),
      ),
    );
  }
}
