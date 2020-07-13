
import 'package:flutterrechargecount/models/message.dart';
import 'package:flutterrechargecount/models/transaction.dart';
import 'package:flutterrechargecount/services/api.dart';
import 'package:flutterrechargecount/services/firestore_service.dart';

abstract class Database{
  Future<void> addTransaction(TransactionClass transaction);
  Stream<List<TransactionClass>> transactionStream();
  Future<void> updateTransaction(String docId);
  Future<void> deleteTransaction(String docId);
  Stream<List<TransactionClass>> nonPaidStream();
  Future<void> sendMessage(Message message);
  Stream<List<Message>> messageStream();
}

class FirestoreDatabase implements Database{
  FirestoreDatabase({this.uid}): assert(uid != null);
  final String uid;
  final _service = FirestoreService.instance;

  @override
  Future<void> addTransaction(TransactionClass transaction) async => await _service.addData(
    path: APIPath.transactions(),
    data: transaction.toJson(),
  );

  @override
  Future<void> sendMessage(Message message) async => await _service.addData(
    path: APIPath.messages(),
    data: message.toJson(),
  );

  @override
  Stream<List<Message>> messageStream() => _service.collectionStream<Message>(
      path: APIPath.messages(),
      builder: (data,docId) => Message.fromJson(data),
      field: "sentAt",
      descending: true
  );

  @override
  Stream<List<TransactionClass>> transactionStream() => _service.collectionStream<TransactionClass>(
    path: APIPath.transactions(),
    builder: (data,docId) => TransactionClass.fromJson(data,docId),
    field: "time",
    descending: true
  );

  @override
  Future<void> updateTransaction(String docId) async => await _service.update(docPath:APIPath.transactions()+'/'+docId,data: {
    "paid":true
  } );

  @override
  Future<void> deleteTransaction(String docId) async => await _service.delete(docPath:APIPath.transactions()+'/'+docId);

  @override
  Stream<List<TransactionClass>> nonPaidStream() => _service.collectionNonPaid<TransactionClass>(
    path: APIPath.transactions(),
    builder: (data,docId) => TransactionClass.fromJson(data,docId),
  );

}