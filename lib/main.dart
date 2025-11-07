import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'features/app_state.dart';
import 'features/auth/screens/auth_screen.dart';
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
        theme: ThemeData(primarySwatch: Colors.pink, useMaterial3: true),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(
      path: '/auth',
      pageBuilder: (context, state) {
        return NoTransitionPage(child: AuthScreen());
      },
    ),
    GoRoute(
      path: '/menu',
      pageBuilder: (context, state) {
        return const MaterialPage(child: MenuScreen());
      },
      routes: [
        GoRoute(
          path: 'cart',
          pageBuilder: (context, state) {
            return const MaterialPage(child: CartScreen());
          },
        ),
        GoRoute(
          path: 'orders',
          pageBuilder: (context, state) {
            return const MaterialPage(child: OrdersScreen());
          },
        ),
        GoRoute(
          path: 'checkout',
          pageBuilder: (context, state) {
            return const MaterialPage(child: CheckoutScreen());
          },
        ),
        GoRoute(
          path: 'profile',
          pageBuilder: (context, state) {
            return const MaterialPage(child: ProfileScreen());
          },
        ),
      ],
    ),
  ],
);
