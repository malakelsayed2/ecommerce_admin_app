import 'package:ecommerce_admin_app/repositories/product_repository.dart';
import 'package:ecommerce_admin_app/services/product_db_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../controllers/product_controller.dart';
import '../models/product_model.dart';

final productDbService = Provider((ref) => ProductDbService(),) ;

final productRepoProvider = Provider((ref){
  final dbService = ref.watch(productDbService) ;
  return ProductRepository(dbService) ;
});

final productListProvider = StreamProvider<List<ProductModel>>((ref){
  final repo = ref.watch(productRepoProvider) ;
  return repo.getAllProducts() ;
});


final productControllerProvider = StateNotifierProvider<ProductController,bool>((ref){
  final repo = ref.watch(productRepoProvider) ;
  return ProductController(repo) ;
});

