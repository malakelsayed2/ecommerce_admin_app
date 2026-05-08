import 'package:flutter/material.dart';

import 'app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF1E2B3C),
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          'Orders Page',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

