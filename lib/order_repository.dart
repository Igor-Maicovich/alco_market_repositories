import 'package:alco_market_models/alco_market_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderRepository {
  CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection('Orders');

  Future<List<Order>> getNewOrders() async {
    var snapshot = await collection.where("doneStatus", isEqualTo: false).get();
    return snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList();
  }

  Future<List<Order>> getPreviewsOrders() async {
    var snapshot = await collection.where("doneStatus", isEqualTo: true).get();
    return snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList();
  }

  Future<void> createOrder(Order order) async {
    return await collection.doc(order.id).set(order.toJson());
  }

  Future<void> updateOrderStatus(Order order) async {
    return await collection.doc(order.id).update({"doneStatus": order.status});
  }

  Future<void> deleteOrder(Order order) async {
    return await collection.doc(order.id).delete();
  }
}
