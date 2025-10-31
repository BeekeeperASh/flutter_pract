import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'features/app_state.dart';
import 'features/menu/screens/menu_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/cart/screens/cart_screen.dart';
import 'features/orders/screens/orders_screen.dart';
import 'features/cart/screens/checkout_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Sweet Delights',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/menu',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainNavigationScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/menu',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: MenuScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: 'cart',
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                      child: CartScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: 'orders',
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                      child: OrdersScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: 'checkout',
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                      child: CheckoutScreen(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: ProfileScreen(),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

class MainNavigationScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigationScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Меню',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}