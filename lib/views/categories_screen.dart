import 'package:ecommerce_admin_app/models/category_model.dart';
import 'package:ecommerce_admin_app/providers/category_provider.dart';
import 'package:ecommerce_admin_app/views/products_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_drawer.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  final TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final catList = ref.watch(categoryListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Clean light background
      appBar: AppBar(
        title: catList.when(
          data: (data) => Text(
            'Categories (${data.length})',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3A4A),
            ),
          ),
          error: (_, __) => const Text('Error'),
          loading: () => const Text('Loading...'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Color(0xFF2D3A4A)),
      ),
      drawer: const AppDrawer(),
      body: catList.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.category_outlined, size: 64, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text('No categories found. Add your first one!',
                      style: TextStyle(color: Color(0xFF5F6C7B))),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final category = data[index];

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductsScreen(categoryName: category.name),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Icon Container
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF1FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.category_outlined,
                            color: Color(0xFF246BFD),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Category Name
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D3A4A),
                                ),
                              ),
                              Text(
                                "Manage products in this category",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Delete Button
                        IconButton(
                          onPressed: () {
                            ref
                                .read(categoryControllerProvider.notifier)
                                .deleteCategory(category);
                          },
                          icon: const Icon(CupertinoIcons.delete,
                              color: Color(0xFFE63946), size: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => Center(child: Text('$error')),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFF246BFD)),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCategoryModal(context, ref),
        backgroundColor: const Color(0xFF246BFD),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "New Category",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _showAddCategoryModal(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Add Category',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3A4A),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(
                  hintText: 'e.g. Electronics',
                  prefixIcon: const Icon(Icons.label_important_outline, color: Color(0xFF246BFD)),
                  filled: true,
                  fillColor: const Color(0xFFF8F9FA),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF246BFD), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    final name = categoryController.text.trim();
                    if (name.isNotEmpty) {
                      ref.read(categoryControllerProvider.notifier)
                          .addCategory(CategoryModel(id: "", name: name));
                      categoryController.clear();
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF246BFD),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Create Category',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}