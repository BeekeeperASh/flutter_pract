import '../../cart/models/cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final DateTime createdAt;
  final double total;
  final String? comment;

  const Order({
    required this.id,
    required this.items,
    required this.createdAt,
    required this.total,
    this.comment,
  });

  Order copyWith({
    String? comment,
  }) {
    return Order(
      id: id,
      items: items,
      createdAt: createdAt,
      total: total,
      comment: comment ?? this.comment,
    );
  }
}