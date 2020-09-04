import 'package:flutter/foundation.dart';

class Product {
  final String productName;
  final String unitType;
  final double unitPrice;
  final String vendorId; //==> user id from firebase how added this product
  final String productId;
  final String imageUrl; //==> optional
  final bool approved; //==> administrate will approve;
  final String note; 
  final int availableUnits;

  Product(
      {@required this.productName,
      @required this.unitType,
      @required this.unitPrice,
      @required this.availableUnits,
      @required this.vendorId,
      @required this.productId,
      @required this.approved,
      this.imageUrl = '',
      this.note=''});

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'unitType': unitType,
      'unitPrice': unitPrice,
      'availableUnits' : availableUnits,
      "vendorId": vendorId,
      'productId': productId,
      'approved': approved,
      'imageUrl': imageUrl,
      'note': note
    };
  }

  Product.fromFirestore(Map<String, dynamic> firestore)
      : productName = firestore['productName'],
        productId = firestore['productId'],
        unitType = firestore['unitType'],
        unitPrice = firestore['unitPrice'],
        availableUnits = firestore['availableUnits'],
        vendorId = firestore['vendorId'],
        imageUrl = firestore['imageUrl'],
        approved = firestore['approved'],
        note = firestore['note'];
}
