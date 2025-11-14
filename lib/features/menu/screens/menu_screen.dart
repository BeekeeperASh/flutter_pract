import 'package:flutter/material.dart';
import 'package:flutter_pract/features/profile/screens/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../shared/providers/app_providers.dart';
import '../../app_state.dart';
import '../widgets/menu_item_tile.dart';
import '../../../shared/widgets/empty_state.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuItems = ref.watch(menuItemsProvider);
    final totalCartItemsCount = ref.watch(totalCartItemsCountProvider);

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
              if (totalCartItemsCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    radius: 8,
                    child: Text(
                      totalCartItemsCount.toString(),
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
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/menu/profile'),
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
            onAddToCart: () => ref.read(cartProvider.notifier).addToCart(item),
          );
        },
      ),
    );
  }
}
