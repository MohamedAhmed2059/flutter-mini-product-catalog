import 'package:go_router/go_router.dart';

import 'details_page.dart';
import 'login_page.dart';
import 'products_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    // Query parameter: /products?user=Guest
    GoRoute(
      path: '/products',
      name: 'products',
      builder: (context, state) => ProductsPage(
        username: state.uri.queryParameters['user'] ?? 'Guest',
      ),
    ),
    // Path parameters: /details/Laptop/1200
    GoRoute(
      path: '/details/:name/:price',
      name: 'details',
      builder: (context, state) => DetailsPage(
        name: state.pathParameters['name']!,
        price: int.parse(state.pathParameters['price']!),
      ),
    ),
  ],
);
