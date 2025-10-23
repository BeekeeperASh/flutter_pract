import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${item.price.toInt()} ₽ × ${item.quantity}'),
            Text('Итого: ${(item.price * item.quantity).toInt()} ₽',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onRemove,
          tooltip: 'Удалить из корзины',
        ),
      ),
    );
  }
}