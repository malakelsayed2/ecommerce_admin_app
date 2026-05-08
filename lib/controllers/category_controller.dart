import 'package:ecommerce_admin_app/repositories/category_repository.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/category_model.dart';

class CategoryController extends StateNotifier<bool>{

  final CategoryRepository _repo ;
  CategoryController(this._repo) : super(false) ;

  Future<void> addCategory(CategoryModel category)async {
    state = true ;
    try{
      await _repo.addCategories(category) ;
    }finally{
      state = true ;

    }
  }

  Future<void> updateCategory(CategoryModel category)async {
    state = true ;
    try{
      await _repo.updateCategories(category) ;
    }finally{
      state = true ;

    }
  }


  Future<void> deleteCategory(CategoryModel category)async {
    state = true ;
    try{
      await _repo.deleteCategories(category) ;
    }finally{
      state = true ;

    }
  }
}