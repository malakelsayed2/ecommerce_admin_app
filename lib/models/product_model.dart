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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imgUrl': imgUrl,
      'price': price,
      'discount': discount,
      'stock': stock,
      'createdAt': createdAt,
      'category': category,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map, String id){
    return ProductModel(
        id: id,
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        imgUrl: map['imgUrl'] ?? '',
        price: (map['price'] ?? 0.0).toDouble(),
        discount: (map['discount'] ?? 0.0).toDouble(),
        stock: map['stock'] ?? 0,
        createdAt: map['createdAt'] ?? Timestamp.now(),
        category: map['category'] ?? '');
  }
}