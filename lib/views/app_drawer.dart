import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Modern Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 30, left: 24),
            decoration: const BoxDecoration(
              color: Color(0xFF246BFD),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                SizedBox(height: 15),
                Text(
                  'Admin Panel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'workspace@market.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Drawer Items
          _buildDrawerItem(
            context: context,
            icon: Icons.dashboard_outlined,
            label: 'Orders',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const OrdersScreen()),
              );
            },
          ),
          _buildDrawerItem(
            context: context,
            icon: Icons.grid_view_rounded,
            label: 'Categories',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const CategoriesScreen()),
              );
            },
          ),

          const Spacer(),
          const Divider(indent: 20, endIndent: 20),

          _buildDrawerItem(
            context: context,
            icon: Icons.logout_rounded,
            label: 'Logout',
            color: Colors.redAccent,
            onTap: () {
              // Handle Logout logic here
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: color ?? const Color(0xFF246BFD)),
        title: Text(
          label,
          style: TextStyle(
            color: color ?? const Color(0xFF2D3A4A),
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: onTap,
        tileColor: Colors.transparent,
        hoverColor: const Color(0xFFEAF1FF),
      ),
    );
  }
}