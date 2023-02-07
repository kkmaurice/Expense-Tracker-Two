//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expens_tracker/model/transactions_model.dart';

class TransactionService{

   final CollectionReference _ref = FirebaseFirestore.instance.collection('transactions');

   Future<void> addTransaction(TransactionModel data) async {
     await _ref.doc(data.id).set(data.toMap());
   }

   // fetch all transactions
   Future getTransactions() async {
     final snapshot = await _ref.get();
     return snapshot.docs.map((doc) => TransactionModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
   }

   // query transactions by type
    Future getTransactionsByType() async {
      final snapshot = await _ref.where('type', isEqualTo: 'Expense').get();
      return snapshot.docs.map((doc) => TransactionModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    }

    // query transactions by date
    Future getTransactionsByDate() async {
      final snapshot = await _ref.where('date', isGreaterThan: '2021-09-01').get();
      return snapshot.docs.map((doc) => TransactionModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    }
   
}