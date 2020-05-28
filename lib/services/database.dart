
import 'package:flutterrechargecount/models/transaction.dart';
import 'package:flutterrechargecount/services/api.dart';
import 'package:flutterrechargecount/services/firestore_service.dart';

abstract class Database{
  Future<void> addTransaction(TransactionClass transaction);
  Stream<List<TransactionClass>> transactionStream();
}

class FirestoreDatabase implements Database{
  FirestoreDatabase({this.uid}): assert(uid != null);
  final String uid;
  final _service = FirestoreService.instance;

  @override
  Future<void> addTransaction(TransactionClass transaction) async => await _service.addData(
    path: APIPath.transactions(uid),
    data: transaction.toJson(),
  );

  @override
  Stream<List<TransactionClass>> transactionStream() => _service.collectionStream(
    path: APIPath.transactions(uid),
    builder: (data) => TransactionClass.fromJson(data),
  );

}