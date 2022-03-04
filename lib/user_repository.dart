import 'package:alco_market_models/alco_market_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection('Users');

  Future<List<User>> getAllUsers() async {
    var snapshot = await collection.get();
    return snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
  }

  Future<User?> getUserById(String id) async {
    var snapshot = await collection.doc(id).get();
    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
    return null;
  }

  Future<void> createUser(User user) async {
    return await collection.doc(user.id).set(user.toJson());
  }

  Future<void> updateUser(User user) async {
    return await collection.doc(user.id).set(user.toJson());
  }

  Future<void> deleteUser(User user) async {
    return await collection.doc(user.id).delete();
  }
}
