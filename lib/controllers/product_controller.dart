import 'package:ecommerce_admin_app/repositories/product_repository.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/product_model.dart';

class ProductController extends StateNotifier<bool>{
  final ProductRepository _repo ;
  ProductController(this._repo) : super(false) ;


  Future<void> addProduct(ProductModel product) async {
    state = true ;
    try{
      await _repo.addProduct(product) ;
    }finally{
      state = true ;

    }
  }


  Future<void> updateProduct(ProductModel product)async{
    state = true ;
    try{
      _repo.updateProduct(product) ;
    }finally{
      state = false ;
    }
  }

  Future<void> deleteProduct(ProductModel product)async{
    state = true ;
    try{
      _repo.deleteProduct(product) ;
    }finally{
      state = false ;
    }
  }
}