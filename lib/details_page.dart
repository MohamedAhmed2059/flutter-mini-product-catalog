import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.name, required this.price});

  final String name;
  final int price;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    print('DetailsPage: initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('DetailsPage: didChangeDependencies');
  }

  @override
  void deactivate() {
    print('DetailsPage: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('DetailsPage: dispose');
    super.dispose();
  }

  void _addToCart() {
    // Part 2 (Navigator):
    // Navigator.pop(context, '${widget.name} added to cart');

    // Part 3 (go_router):
    context.pop('${widget.name} added to cart');
  }

  @override
  Widget build(BuildContext context) {
    print('DetailsPage: build');
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.name, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 8),
            Text('\$${widget.price}', style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _addToCart,
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
