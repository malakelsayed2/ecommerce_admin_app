import 'package:ecommerce_admin_app/services/product_db_service.dart';

import '../models/product_model.dart';

class ProductRepository{
  final ProductDbService _dbService;

  ProductRepository(this._dbService) ;

  Stream<List<ProductModel>> getAllProducts() => _dbService.getAllProducts() ;

  Future<void> addProduct(ProductModel product) => _dbService.addProduct(product) ;

  Future<void> updateProduct(ProductModel product) => _dbService.updateProduct(product) ;

  Future<void> deleteProduct(ProductModel product) => _dbService.deleteProduct(product) ;



}