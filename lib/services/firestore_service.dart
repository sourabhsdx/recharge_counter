
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> addData({String path, Map<String, dynamic> data}) async {
    final reference = Firestore.instance.collection(path);
    await reference.add(data);
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String docId),
    @required String field,
    @required bool descending
  }) {
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.orderBy(field,descending: descending).snapshots();
    return snapshots.map((snapshot) =>
        snapshot.documents.map((snaps) => builder(snaps.data,snaps.documentID)).toList());
  }



  Stream<List<T>> collectionNonPaid<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String docId),
  }) {
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.where("paid",isEqualTo: false).snapshots();
    return snapshots.map((snapshot) =>
        snapshot.documents.map((snaps) => builder(snaps.data,snaps.documentID)).toList());
  }

  Future<void> update({String docPath,Map<String,dynamic> data}) async {
    final reference = Firestore.instance.document(docPath);
    await reference.updateData(data);
  }

  Future<void> delete({String docPath}) async {
    final reference = Firestore.instance.document(docPath);
    await reference.delete();
  }


}