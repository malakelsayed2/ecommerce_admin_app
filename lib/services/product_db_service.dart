import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductDbService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final collectionName = "products";

  Stream<List<ProductModel>> getAllProducts() {
    return _firestore
        .collection(collectionName)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> addProduct(ProductModel product){
    return _firestore.collection(collectionName).add(product.toMap());
  }

  Future<void> updateProduct(ProductModel product){
    return _firestore.collection(collectionName).doc(product.id).update(product.toMap());
  }

  Future<void> deleteProduct(ProductModel product){
    return _firestore.collection(collectionName).doc(product.id).delete();
  }
}
