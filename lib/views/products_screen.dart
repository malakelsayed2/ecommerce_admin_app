import 'package:ecommerce_admin_app/models/product_model.dart';
import 'package:flutter/cupertino.dart'; // Added for consistent icons
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsScreen extends ConsumerWidget {
  final String categoryName;

  const ProductsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsList = ref.watch(productListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light background for contrast
      appBar: AppBar(
        title: Text(
          categoryName,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2D3A4A)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Color(0xFF2D3A4A)),
      ),
      body: productsList.when(
        data: (products) {
          final filteredProducts = products.where((p) => p.category == categoryName).toList();

          if (filteredProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    "No products in $categoryName",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      // Product Image with soft corners
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          product.imgUrl,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 90,
                            height: 90,
                            color: const Color(0xFFEAF1FF),
                            child: const Icon(Icons.image_not_supported, color: Color(0xFF246BFD)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Product Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D3A4A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey[600], fontSize: 13),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${product.price.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    color: Color(0xFF246BFD),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEAF1FF),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "QTY: ${product.stock}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF246BFD),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        error: (err, stack) => Center(child: Text("Error: $err")),
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF246BFD))),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddProductModal(context, ref, categoryName),
        backgroundColor: const Color(0xFF246BFD),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Add Product", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

void _showAddProductModal(BuildContext context, WidgetRef ref, String categoryName) {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final stockController = TextEditingController();
  final imgController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "New Product Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2D3A4A)),
            ),
            const SizedBox(height: 20),
            _buildStyledField(nameController, "Product Name", Icons.shopping_bag_outlined),
            const SizedBox(height: 12),
            _buildStyledField(descController, "Description", Icons.description_outlined, maxLines: 2),
            const SizedBox(height: 12),
            _buildStyledField(imgController, "Image URL", Icons.link_outlined),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildStyledField(priceController, "Price", Icons.attach_money, isNumber: true)),
                const SizedBox(width: 12),
                Expanded(child: _buildStyledField(stockController, "Stock", Icons.inventory_2_outlined, isNumber: true)),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF246BFD),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                onPressed: () {
                  if (nameController.text.isEmpty || priceController.text.isEmpty) return;

                  final newProduct = ProductModel(
                    id: '',
                    name: nameController.text.trim(),
                    description: descController.text.trim(),
                    imgUrl: imgController.text.trim(),
                    price: double.tryParse(priceController.text) ?? 0.0,
                    discount: double.tryParse(discountController.text) ?? 0.0,
                    stock: int.tryParse(stockController.text) ?? 0,
                    createdAt: Timestamp.now(),
                    category: categoryName,
                  );

                  ref.read(productControllerProvider.notifier).addProduct(newProduct);
                  Navigator.pop(context);
                },
                child: const Text("Create Product", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

Widget _buildStyledField(TextEditingController controller, String label, IconData icon, {int maxLines = 1, bool isNumber = false}) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFF246BFD), size: 20),
      filled: true,
      fillColor: const Color(0xFFF8F9FA),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF246BFD), width: 1.5)),
    ),
  );
}