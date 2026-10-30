import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'product_widgets.dart';

// Part 2 (Navigator): only needed for the commented Navigator.push below.
// import 'details_page.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.username});

  final String username;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final List<Map<String, dynamic>> _products = [
    {'name': 'Laptop', 'price': 1200},
    {'name': 'Phone', 'price': 800},
    {'name': 'Headphones', 'price': 150},
    {'name': 'Keyboard', 'price': 90},
    {'name': 'Mouse', 'price': 40},
    {'name': 'Monitor', 'price': 300},
  ];

  int _favorites = 0;
  double _screenWidth = 0;
  String _cartMessage = '';

  @override
  void initState() {
    super.initState();
    print('ProductsPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.sizeOf(context);
    _screenWidth = size.width;
    print('ProductsPage: didChangeDependencies -> '
        'width: ${size.width}, height: ${size.height}');
  }

  @override
  void deactivate() {
    print('ProductsPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('ProductsPage: dispose');
    super.dispose();
  }

  void _addFavorite() {
    setState(() {
      _favorites++;
    });
  }

  Future<void> _openDetails(int index) async {
    final String name = _products[index]['name'];
    final int price = _products[index]['price'];

    // Part 2 (Navigator): push and send the data through the constructor.
    // final result = await Navigator.push<String>(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => DetailsPage(name: name, price: price),
    //   ),
    // );

    // Part 3 (go_router): push, so Details goes on top of Products and
    // pop can send a result back.
    final result = await context.push<String>(
      '/details/${Uri.encodeComponent(name)}/$price',
    );

    if (!mounted) return;
    if (result != null) {
      setState(() {
        _cartMessage = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('ProductsPage: build');
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${widget.username}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Favorites: $_favorites'),
            Text('Screen width: ${_screenWidth.toStringAsFixed(0)}'),
            if (_cartMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  _cartMessage,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            const SizedBox(height: 8),
            Expanded(
              child: _screenWidth < 600
                  ? ProductsListView(
                      products: _products,
                      onFavoritePressed: _addFavorite,
                      onProductTap: _openDetails,
                    )
                  : ProductsGridView(
                      products: _products,
                      onFavoritePressed: _addFavorite,
                      onProductTap: _openDetails,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
