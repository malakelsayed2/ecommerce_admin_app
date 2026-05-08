import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../views/orders_screen.dart';

class EcommerceAdminApp extends StatelessWidget {
  const EcommerceAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const OrdersScreen(),
      ),
    );
  }
}



