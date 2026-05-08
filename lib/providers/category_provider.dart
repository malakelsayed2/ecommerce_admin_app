import 'package:ecommerce_admin_app/controllers/category_controller.dart';
import 'package:ecommerce_admin_app/models/category_model.dart';
import 'package:ecommerce_admin_app/repositories/category_repository.dart';
import 'package:ecommerce_admin_app/services/category_db_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

//db_service provider
final categoryDbService = Provider((ref) => CategoryDbService());

//repo
final catRepoProvider = Provider((ref) {
  final dbService = ref.watch(categoryDbService);
  return CategoryRepository(dbService);
});

//stream
final categoryListProvider = StreamProvider<List<CategoryModel>>((ref) {
  final repo = ref.watch(catRepoProvider);
  return repo.getCategories();
});

//controller for actions (add,update,delete)
final categoryControllerProvider =
    StateNotifierProvider<CategoryController, bool>((ref) {
      final repo = ref.watch(catRepoProvider);
      return CategoryController(repo);
    });
