import 'package:alco_market_models/alco_market_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentRepository {
  CollectionReference<Map<String, dynamic>> comments = FirebaseFirestore.instance.collection('Comments');

  Future<List<Comment>> getNewComments() async {
    var snapshot = await comments.where("readStatus", isEqualTo: false).get();
    return snapshot.docs.map((doc) => Comment.fromJson(doc.data())).toList();
  }

  Future<List<Comment>> getPreviewsComments() async {
    var snapshot = await comments.where("readStatus", isEqualTo: true).get();
    return snapshot.docs.map((doc) => Comment.fromJson(doc.data())).toList();
  }

  Future<void> createComment(Comment comment) async {
    return await comments.doc(comment.id).set(comment.toJson());
  }

  Future<void> updateComment(Comment comment) async {
    return await comments.doc(comment.id).update({"readStatus": comment.readStatus});
  }

  Future<void> deleteComment(Comment comment) async {
    return await comments.doc(comment.id).delete();
  }
}
