class CartItem {
  final String id;
  final String menuItemId;
  final String title;
  final int quantity;
  final double price;

  const CartItem({
    required this.id,
    required this.menuItemId,
    required this.title,
    required this.quantity,
    required this.price,
  });

  CartItem copyWith({
    int? quantity,
  }) {
    return CartItem(
      id: id,
      menuItemId: menuItemId,
      title: title,
      quantity: quantity ?? this.quantity,
      price: price,
    );
  }
}