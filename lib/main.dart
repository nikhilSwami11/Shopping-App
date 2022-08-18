import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './providers/cart.dart';
import './screen/products_overview_screen.dart';
import './screen/product_detail_screen.dart';
import './providers/products.dart';
import './screen/cart_screen.dart';
import './providers/orders.dart';
import './screen/orders_screen.dart';
import './screen/user_product_screen.dart';
import './screen/edit_product_screen.dart';
import './screen/auth_screen.dart';
import './providers/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
              create: (ctx) => Products('', []),
              update: (ctx, auth, previosProducts) {
                return Products(auth.token == null ? '' : auth.token.toString(),
                    previosProducts == null ? [] : previosProducts.items);
              }),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Orders(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (cxt, auth, _) => MaterialApp(
            title: 'Shop App',
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              accentColor: Colors.orange,
            ),
            debugShowCheckedModeBanner: false,
            home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
            routes: {
              //ProductOverviewScreen.routeName: (ctx) => ProductOverviewScreen(),
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductScreen.routeName: (ctx) => UserProductScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen()
            },
          ),
        ));
  }
}
