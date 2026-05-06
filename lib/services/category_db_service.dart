import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_app/models/category_model.dart';

class CategoryDbService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String collectionName = "categories";

  //get categories
  Stream<List<CategoryModel>> getCategories() {
    return _firestore
        .collection(collectionName)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  //add categories
  Future<void> addCategories(CategoryModel category) {
    return _firestore.collection(collectionName).add(category.toMap());
  }

  //update categories
  Future<void> updateCategories(CategoryModel category) {
    return _firestore
        .collection(collectionName)
        .doc(category.id)
        .update(category.toMap());
  }

  //delete categories
  Future<void> deleteCategories(CategoryModel category) {
    return _firestore.collection(collectionName).doc(category.id).delete();
  }
}
