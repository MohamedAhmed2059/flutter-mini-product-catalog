// ============================================================================
// Part 1 - Lifecycle answers
// (taken from the console prints while using the app)
//
// a) Which methods run when a page opens for the first time?
//    initState -> didChangeDependencies -> build.
//    e.g. "ProductsPage: initState", "ProductsPage: didChangeDependencies ->
//    width: ..., height: ...", "ProductsPage: build".
//
// b) Which method runs again after you press the heart button?
//    Only build. setState marks the State as dirty, so Flutter calls build
//    again with the new "Favorites: X". initState does NOT run again.
//
// c) Which methods run when you leave a page and go back?
//    - Products -> Details (push): Details runs initState ->
//      didChangeDependencies -> build. Products is NOT disposed, it stays in
//      the stack under Details.
//    - Details -> back (pop): Details runs deactivate -> dispose, and Products
//      runs build again because setState shows the "... added to cart" text.
//      Products doesn't run initState again because it never left the stack.
//    - Login -> Products (go): Login runs deactivate -> dispose because go
//      replaces the whole stack.
//
// d) Which methods run when you resize the browser window, and why?
//    didChangeDependencies -> build on ProductsPage. In didChangeDependencies
//    we call MediaQuery.sizeOf(context), which makes the page depend on the
//    screen size. When the window is resized, MediaQuery changes and Flutter
//    calls didChangeDependencies on every widget that depends on it, then
//    rebuilds it. That's where we read the new width, and the page switches
//    between the ListView (< 600) and the GridView (>= 600).
//
// ============================================================================
// Part 4 - Short answers
//
// 1) What is the difference between context.go and context.push?
//    - go replaces the whole navigation stack with the pages for the new
//      location. There is nothing to go back to.
//      Example: Login -> Products uses
//      context.goNamed('products', queryParameters: {'user': 'Guest'}).
//    - push adds the new page ON TOP of the current stack, so the old page
//      stays alive and pop can go back to it (and return a result).
//      Example: Products -> Details uses
//      context.push('/details/Laptop/1200'), and Details goes back with
//      context.pop('Laptop added to cart').
//
// 2) Why did we use go for Login -> Products and push for Products -> Details?
//    After logging in the user should not be able to press back and see the
//    Login page again, so we throw the Login page away with go. Details is a
//    page on top of the list: the user should be able to go back to the same
//    Products page (same favorites counter) and we need pop to send back the
//    "added to cart" result, which only works with push.
//
// 3) What is the difference between a path parameter and a query parameter?
//    - Path parameter: part of the path itself, declared in the route with
//      ":", and required for the route to match.
//      URL: /details/Laptop/1200 -> route "/details/:name/:price",
//      read with state.pathParameters['name'] and ['price'].
//    - Query parameter: optional key=value pairs after "?", not declared in
//      the route path.
//      URL: /products?user=Guest -> read with
//      state.uri.queryParameters['user'].
// ============================================================================

import 'package:flutter/material.dart';

import 'router.dart';

// Part 2 (Navigator): only needed for the commented MaterialApp below.
// import 'login_page.dart';
// import 'products_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Part 2 (Navigator version, kept but commented out):
    // pushNamed sends the username as "arguments", and the route reads it
    // with ModalRoute.of(context)!.settings.arguments.
    //
    // return MaterialApp(
    //   title: 'Mini Product Catalog',
    //   debugShowCheckedModeBanner: false,
    //   initialRoute: '/',
    //   routes: {
    //     '/': (context) => const LoginPage(),
    //     '/products': (context) => ProductsPage(
    //           username: ModalRoute.of(context)!.settings.arguments as String,
    //         ),
    //   },
    // );

    // Part 3 (go_router version, active):
    return MaterialApp.router(
      title: 'Mini Product Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      routerConfig: router,
    );
  }
}
