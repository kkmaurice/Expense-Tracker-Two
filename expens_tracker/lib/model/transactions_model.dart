class TransactionModel {
  String id;
  String type;
  double amount;
  String description;
  DateTime date;
  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
  });

  @override
  String toString() {
    return '$amount\n$type\n$date\n$description';
  }

  factory TransactionModel.fromMap(Map<String, dynamic> data){
    return TransactionModel(
      type: data['type'] ?? '', 
      amount: data['amount'] ?? '', 
      description: data['description'] ?? '', 
      date: DateTime.parse(data['date']), 
      id: data['id'] ?? '');
  }
  Map<String, dynamic> toMap(){
    return {
      'type': type,
      'amount': amount,
      'description': description,
      'date': DateTime.now().toIso8601String(),
      'id': id
    };
  }
  
}
