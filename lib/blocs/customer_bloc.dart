import 'package:farmer_market/models/market.dart';
import 'package:farmer_market/models/product.dart';
import 'package:farmer_market/services/firestore_service.dart';


class CustomerBloc {
  final db = FirestoreService();

  //get
  Stream<List<Market>> get fetchUpcomingMarket => db.fetchUpcomingMarket();
  Stream<List<Product>> get fetchAvailableProducts => db.fetchAvailableProduct();
  dispose(){
     
  }
}
