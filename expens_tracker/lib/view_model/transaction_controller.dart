import 'package:expens_tracker/model/transactions_model.dart';
import 'package:expens_tracker/services/transaction_service.dart';
import 'package:flutter/cupertino.dart';

class Controller with ChangeNotifier {
  final TransactionService _transactionService = TransactionService();
  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  double get totalIncome => _transactions
      .where((element) => element.type == 'Income')
      .fold(0.0, (previousValue, element) => previousValue + element.amount);

  double get totalExpense => _transactions.where((element) => element.type == 'Expense').fold(0.0, (previousValue, element) => previousValue + element.amount);

  double get totalBalance => totalIncome - totalExpense;


  Future addToDb( 
    {required String id,
    required String type,
    required double amount,
    required String description,
    required DateTime date,}
  ) async {
    if(id.isNotEmpty && type.isNotEmpty && amount != 0 && description.isNotEmpty){
      await _transactionService.addTransaction(TransactionModel(
        id: id,
        type: type,
        amount: amount,
        description: description,
        date: date,
      ));
    }
  }

  Future<List<TransactionModel>> fetchTransactions() async {
    var transaction = await _transactionService.getTransactions();
    print(transaction);
    if(transaction is List<TransactionModel>){
      _transactions = transaction;
  }
  notifyListeners();
  return _transactions;
  }

  // get transactions by type
  Future<List<TransactionModel>> fetchTransactionsByItsType() async {
    var transaction = await _transactionService.getTransactionsByType();
    print(transaction);
    if(transaction is List<TransactionModel>){
      _transactions = transaction;
    }
    notifyListeners();
    return _transactions;
  }
}
