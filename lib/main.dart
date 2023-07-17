import 'package:ch13/cart_provider.dart';
import 'package:ch13/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => cartprovider(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
              debugShowCheckedModeBanner: false, home: productlist());
        },
      ),
    );
  }
}
