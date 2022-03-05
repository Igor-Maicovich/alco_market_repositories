import 'package:alco_market_models/alco_market_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BeverageRepository {
  CollectionReference<Map<String, dynamic>> beveragesCollection = FirebaseFirestore.instance.collection('Beverages');
  CollectionReference<Map<String, dynamic>> categoriesCollection = FirebaseFirestore.instance.collection('Categories');

  Future<List<CategoryBeverage>> getCategories() async {
    var snapshot = await categoriesCollection.get();
    return snapshot.docs.map((doc) => CategoryBeverage.fromJson(doc.data())).toList();
  }

  Future<List<Beverage>> getAllBeverages() async {
    var snapshot = await beveragesCollection.get();
    return snapshot.docs.map((doc) => Beverage.fromJson(doc.data())).toList();
  }

    Future<Beverage?> getBeverageById(String id) async {
    var snapshot = await beveragesCollection.doc(id).get();
    if (snapshot.exists) {
      return Beverage.fromJson(snapshot.data()!);
    }
    return null;
  }
  

  Future<void> createCategory(CategoryBeverage category) async {
    return await categoriesCollection.doc(category.id).set(category.toJson());
  }

  Future<void> createBeverage({required CategoryBeverage category, required Beverage beverage}) async {
    await beveragesCollection.doc(beverage.id).set(beverage.toJson());
    return await categoriesCollection.doc(category.id).set(category.toJson());
  }

  Future<void> updateCategory(CategoryBeverage category) async {
    return await categoriesCollection.doc(category.id).set(category.toJson());
  }

  Future<void> updateBeverage(Beverage beverage) async {
    return await beveragesCollection.doc(beverage.id).set(beverage.toJson());
  }

  Future<void> deleteCategory(CategoryBeverage category) async {
    for (var id in category.beverages) {
      await beveragesCollection.doc(id).delete();
    }
    return await categoriesCollection.doc(category.id).delete();
  }

  Future<void> deleteBeverage(Beverage beverage) async {
    return await beveragesCollection.doc(beverage.id).delete();
}
