import 'package:ecommerce_admin_app/models/category_model.dart';
import 'package:ecommerce_admin_app/providers/category_provider.dart';
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
      appBar: AppBar(
        title: catList.when(
          data: (data) {
            return Text(
              'Categories: ${data.length}',
              style: TextStyle(color: Colors.white),
            );
          },
          error: (error, stackTrace) => Text('$error'),
          loading: () =>
              Text('Loading...', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: const Color(0xFF1E2B3C),
      ),
      drawer: const AppDrawer(),
      body: catList.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(child: Text('Add your first Category!'));
          }

          return Container(
            color: const Color(0xFFF5F7FB),
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD9E1F2)),
              ),
              child: Column(
                children: [

                  // Table header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    color: const Color(0xFFF1F4FA),
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'CATEGORY NAME',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7B8794),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'SLUG',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7B8794),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // List
                  Expanded(
                    child: ListView.separated(
                      itemCount: data.length,
                      separatorBuilder: (_, __) =>
                          const Divider(height: 1, color: Color(0xFFE3E8F0)),
                      itemBuilder: (context, index) {
                        final category = data[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEAF1FF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.category_outlined,
                                        color: Color(0xFF246BFD),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        category.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF2D3A4A),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  category.name,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF5F6C7B),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  ref
                                      .read(categoryControllerProvider.notifier)
                                      .deleteCategory(category);
                                },
                                icon: Icon(CupertinoIcons.delete),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text('$error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1E2B3C),
        child: Text(
          '+',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 45,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 18),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Add New Category',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E2B3C),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8EEF9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Color(0xFF5B6B7F),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Category Name',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF5B6B7F),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: categoryController,
                        decoration: InputDecoration(
                          hintText: 'e.g. Home Appliances',
                          filled: true,
                          fillColor: const Color(0xFFF7F8FC),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFD9E1F2),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFFD9E1F2),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF1E63D8),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),
                      const Divider(height: 1),
                      const SizedBox(height: 22),

                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            final categoryName = categoryController.text.trim();

                            if (categoryName.isNotEmpty) {
                              final newCat = CategoryModel(
                                id: "",
                                name: categoryName,
                              );
                              ref
                                  .read(categoryControllerProvider.notifier)
                                  .addCategory(newCat);
                              categoryController.clear();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Category "$categoryName" created',
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E2B3C),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Create Category',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF5B6B7F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
