import 'package:flutter/material.dart';
import '../features/menu/models/menu_item.dart';
import '../features/cart/models/cart_item.dart';
import '../features/orders/models/order.dart';

class AppState extends ChangeNotifier {
  final List<MenuItem> _menuItems = [
    MenuItem(
      id: '1',
      title: 'Тирамису',
      description: 'Классический итальянский десерт',
      price: 320.0,
      imageAsset: 'https://wallpapers.com/images/hd/yummy-tiramisu-dessert-957xzmxertxk5u3k.jpg',
    ),
    MenuItem(
      id: '2',
      title: 'Эклер',
      description: 'С заварным кремом и шоколадной глазурью',
      price: 180.0,
      imageAsset: 'https://media.komus.ru/medias/sys_master/root/hf0/hba/11929376948254/-.jpg',
    ),
    MenuItem(
      id: '3',
      title: 'Медовик',
      description: 'Нежный медовый торт со сметанным кремом',
      price: 280.0,
      imageAsset: 'https://53a7276f-d68f-462e-a2bf-df223e005be4.selstorage.ru/uploads/media/photo/5383581/bhL30hHWyhk.jpg',
    ),
    MenuItem(
      id: '4',
      title: 'Макарун',
      description: 'Французское пирожное с миндальной основой',
      price: 150.0,
      imageAsset: 'https://mywishboard.app/thumbs/wish/b/o/r/600x0_jkiwxgpqhmkdvnli_jpg_3895.jpg',
    ),
    MenuItem(
      id: '5',
      title: 'Чизкейк Нью-Йорк',
      description: 'Классический чизкейк с нежной текстурой',
      price: 350.0,
      imageAsset: 'https://static.tildacdn.com/tild6539-6436-4863-b965-346365343235/U8MX3O1Bg7gwpJrdUyEo.jpg',
    ),
    MenuItem(
      id: '6',
      title: 'Берлинер',
      description: 'Пончик с заварным кремом внутри, посыпаный сахарной пудрой',
      price: 200.0,
      imageAsset: 'https://static1-repo.aif.ru/1/8c/1790519/dc8a74f07c6178d999a0ba23853e0c4c.jpg',
    ),
  ];

  final List<CartItem> _cartItems = [];
  final List<Order> _orders = [];
  String _orderComment = '';

  List<MenuItem> get menuItems => _menuItems;
  List<CartItem> get cartItems => _cartItems;
  List<Order> get orders => _orders;
  String get orderComment => _orderComment;

  void addToCart(MenuItem item) {
    final index = _cartItems.indexWhere((cartItem) => cartItem.menuItemId == item.id);
    if (index != -1) {
      final existingItem = _cartItems[index];
      _cartItems[index] = existingItem.copyWith(quantity: existingItem.quantity + 1);
    } else {
      _cartItems.add(
        CartItem(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          menuItemId: item.id,
          title: item.title,
          quantity: 1,
          price: item.price,
          imageAsset: '',
        ),
      );
    }
    notifyListeners();
  }

  void removeFromCart(String cartItemId) {
    _cartItems.removeWhere((item) => item.id == cartItemId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void updateOrderComment(String comment) {
    _orderComment = comment;
    notifyListeners();
  }

  void checkout() {
    if (_cartItems.isEmpty) return;

    final newOrder = Order(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      items: List.from(_cartItems),
      createdAt: DateTime.now(),
      total: _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity)),
      comment: _orderComment.isNotEmpty ? _orderComment : null,
    );

    _orders.insert(0, newOrder);
    _cartItems.clear();
    _orderComment = '';
    notifyListeners();
  }

  double get cartTotal {
    return _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  int get totalCartItemsCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }
}