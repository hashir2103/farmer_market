import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmer_market/models/market.dart';
import 'package:farmer_market/models/product.dart';
import 'package:farmer_market/models/user.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(MyUser user) {
    return _db.collection('users').doc(user.userId).set(user.toMap());
  }

  Future<MyUser> fetchUser(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .get() // get return Future
        .then((snap) => MyUser.fromFirestore(snap.data()));
  }

  Stream<List<String>> fetchUnitTypes() {
    return _db
        .collection('types')
        .doc('units')
        .snapshots() //snapshots return streams
        .map((snapshot) => snapshot
            .data()['productions']
            .map<String>((type) => type.toString())
            .toList());
  }

  Future<void> setProduct(Product product) {
    return _db
        .collection('products')
        .doc(product.productId)
        .set(product.toMap());
  }

  Future<Product> fetchProduct(String productId) {
    return _db
        .collection('products')
        .doc(productId)
        .get()
        .then((snapshot) => Product.fromFirestore(snapshot.data()));
  }

  Stream<List<Product>> fetchProductByVendorId(String vendorId) {
    return _db
        .collection('products')
        .where('vendorId', isEqualTo: vendorId)
        .snapshots()
        .map((query) => query.docs)
        .map((snapshot) => snapshot
            .map((document) => Product.fromFirestore(document.data()))
            .toList());
  }

  Stream<List<Market>> fetchUpcomingMarket() {
    return _db
        .collection('markets')
        .where('dateEnd', isGreaterThan: DateTime.now().toIso8601String())
        .snapshots()
        .map((query) => query.docs)
        .map((snapshot) => snapshot.map((doc) => Market.fromFirestor(doc.data())).toList());
  }
  
  Stream<List<Product>> fetchAvailableProduct() {
    return _db
        .collection('products')
        .where('availableUnits',isGreaterThan: 0)
        .snapshots()
        .map((query) => query.docs)
        .map((snapshot) => snapshot.map((doc) => Product.fromFirestore(doc.data())).toList());
  }
}
