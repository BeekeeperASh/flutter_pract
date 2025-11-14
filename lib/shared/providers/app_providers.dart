import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/cart/models/cart_item.dart';
import '../../features/menu/models/menu_item.dart';
import '../../features/orders/models/order.dart';
import '../../features/profile/models/user_model.dart';

final authProvider = StateProvider<bool>((ref) => false);

final userProvider = StateNotifierProvider<UserNotifier, UserModel>(
  (ref) => UserNotifier(),
);

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier() : super(UserModel(id: '1', name: 'Гость'));

  void updateName(String newName) {
    state = state.copyWith(name: newName);
  }

  void setUser(String name) {
    state = UserModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
    );
  }

  void logout() {
    state = UserModel(id: '1', name: 'Гость');
  }
}

final menuItemsProvider = Provider<List<MenuItem>>((ref) {
  return [
    MenuItem(
      id: '1',
      title: 'Тирамису',
      description: 'Классический итальянский десерт',
      price: 320.0,
      imageAsset:
          'https://wallpapers.com/images/hd/yummy-tiramisu-dessert-957xzmxertxk5u3k.jpg',
    ),
    MenuItem(
      id: '2',
      title: 'Эклер',
      description: 'С заварным кремом и шоколадной глазурью',
      price: 180.0,
      imageAsset:
          'https://media.komus.ru/medias/sys_master/root/hf0/hba/11929376948254/-.jpg',
    ),
    MenuItem(
      id: '3',
      title: 'Медовик',
      description: 'Нежный медовый торт со сметанным кремом',
      price: 280.0,
      imageAsset:
          'https://53a7276f-d68f-462e-a2bf-df223e005be4.selstorage.ru/uploads/media/photo/5383581/bhL30hHWyhk.jpg',
    ),
    MenuItem(
      id: '4',
      title: 'Макарун',
      description: 'Французское пирожное с миндальной основой',
      price: 150.0,
      imageAsset:
          'https://mywishboard.app/thumbs/wish/b/o/r/600x0_jkiwxgpqhmkdvnli_jpg_3895.jpg',
    ),
    MenuItem(
      id: '5',
      title: 'Чизкейк Нью-Йорк',
      description: 'Классический чизкейк с нежной текстурой',
      price: 350.0,
      imageAsset:
          'https://static.tildacdn.com/tild6539-6436-4863-b965-346365343235/U8MX3O1Bg7gwpJrdUyEo.jpg',
    ),
    MenuItem(
      id: '6',
      title: 'Берлинер',
      description: 'Пончик с заварным кремом внутри, посыпаный сахарной пудрой',
      price: 200.0,
      imageAsset:
          'https://static1-repo.aif.ru/1/8c/1790519/dc8a74f07c6178d999a0ba23853e0c4c.jpg',
    ),
  ];
});

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(MenuItem item) {
    final index = state.indexWhere(
      (cartItem) => cartItem.menuItemId == item.id,
    );
    if (index != -1) {
      final existingItem = state[index];
      state = [
        ...state.sublist(0, index),
        existingItem.copyWith(quantity: existingItem.quantity + 1),
        ...state.sublist(index + 1),
      ];
    } else {
      state = [
        ...state,
        CartItem(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          menuItemId: item.id,
          title: item.title,
          quantity: 1,
          price: item.price,
          imageAsset: '',
        ),
      ];
    }
  }

  void removeFromCart(String cartItemId) {
    state = state.where((item) => item.id != cartItemId).toList();
  }

  void clearCart() {
    state = [];
  }
}

final ordersProvider = StateNotifierProvider<OrdersNotifier, List<Order>>(
  (ref) => OrdersNotifier(),
);

class OrdersNotifier extends StateNotifier<List<Order>> {
  OrdersNotifier() : super([]);

  void checkout(List<CartItem> cartItems, String? comment) {
    if (cartItems.isEmpty) return;

    final newOrder = Order(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      items: List.from(cartItems),
      createdAt: DateTime.now(),
      total: cartItems.fold(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      ),
      comment: comment,
    );

    state = [newOrder, ...state];
  }
}

final orderCommentProvider = StateProvider<String>((ref) => '');

final cartTotalProvider = Provider<double>((ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
});

final totalCartItemsCountProvider = Provider<int>((ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(0, (sum, item) => sum + item.quantity);
});
