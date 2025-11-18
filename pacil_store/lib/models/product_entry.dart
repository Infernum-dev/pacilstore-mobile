// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) =>
    List<ProductEntry>.from(
      json.decode(str).map((x) => ProductEntry.fromJson(x)),
    );

String productEntryToJson(List<ProductEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
  String id;
  String name;
  String description;
  String category;
  String thumbnail;
  int productViews;
  DateTime createdAt;
  bool isFeatured;
  int userId;

  // Tambahan baru
  int price;
  int stock;

  ProductEntry({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.thumbnail,
    required this.productViews,
    required this.createdAt,
    required this.isFeatured,
    required this.userId,
    required this.price,     // add
    required this.stock,     // add
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    category: json["category"],
    thumbnail: json["thumbnail"],
    productViews: json["product_views"],
    createdAt: DateTime.parse(json["created_at"]),
    isFeatured: json["is_featured"],
    userId: json["user_id"],

    // add
    price: json["price"],
    stock: json["stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "category": category,
    "thumbnail": thumbnail,
    "product_views": productViews,
    "created_at": createdAt.toIso8601String(),
    "is_featured": isFeatured,
    "user_id": userId,

    // add
    "price": price,
    "stock": stock,
  };
}
