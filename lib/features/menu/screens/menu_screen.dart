import 'package:flutter/material.dart';
import 'package:flutter_pract/features/profile/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';
import '../widgets/menu_item_tile.dart';
import '../../../shared/widgets/empty_state.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sweet Delights'),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => context.push('/menu/cart'),
                  ),
                  if (appState.totalCartItemsCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        radius: 8,
                        child: Text(
                          appState.totalCartItemsCount.toString(),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.history),
                onPressed: () => context.push('/menu/orders'),
              ),
              //onPressed: () => context.push('/menu/profile'),
              // onPressed: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => ProfileScreen()),
              //   );
              // },

              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => context.push('/menu/profile'),
              ),
            ],
          ),
          body: appState.menuItems.isEmpty
              ? const EmptyState(
                  message: 'Меню временно недоступно',
                  icon: Icons.cake,
                  imageUrl: '',
                )
              : ListView.builder(
                  itemCount: appState.menuItems.length,
                  itemBuilder: (context, index) {
                    final item = appState.menuItems[index];
                    return MenuItemTile(
                      item: item,
                      onAddToCart: () => appState.addToCart(item),
                    );
                  },
                ),
        );
      },
    );
  }
}
