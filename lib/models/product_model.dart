import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;

  final String name;

  final String description;

  final String imgUrl;

  final double price;

  final double discount;

  final int stock;

  final Timestamp createdAt;

  final String? category;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.price,
    required this.discount,
    required this.stock,
    required this.createdAt,
    required this.category,
  });

  Map<String, dynamic> toMap(ProductModel product) {
    return {
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'imgUrl': product.imgUrl,
      'price': product.price,
      'stock': product.stock,
      'discount': product.discount,
      'createdAt': product.createdAt,
      'category': product.category
    };
  }


  factory ProductModel.fromMap(Map<String, dynamic> map, String id){
    return ProductModel(id: id,
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        imgUrl: map['imgUrl'] ?? '',
        price: map['price'],
        discount: map['discount'],
        stock: map['stock'],
        createdAt: map['createdAt'] ?? DateTime.now(),
        category: map['category'] ?? '');
  }

}
