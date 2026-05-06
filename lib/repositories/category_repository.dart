import 'package:ecommerce_admin_app/models/category_model.dart';
import 'package:ecommerce_admin_app/services/category_db_service.dart';

class CategoryRepository {
  final CategoryDbService _categoryDbService;

  CategoryRepository(this._categoryDbService);

  Stream<List<CategoryModel>> getCategories() =>
      _categoryDbService.getCategories();

  Future<void> addCategories(CategoryModel category) =>
      _categoryDbService.addCategories(category);

  Future<void> updateCategories(CategoryModel category) =>
      _categoryDbService.updateCategories(category);

  Future<void> deleteCategories(CategoryModel category) =>
      _categoryDbService.deleteCategories(category);
}
