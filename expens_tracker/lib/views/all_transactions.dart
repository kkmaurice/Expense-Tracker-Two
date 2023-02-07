import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../view_model/transaction_controller.dart';

class AllTransactionPage extends StatefulWidget {
  const AllTransactionPage({super.key});

  @override
  State<AllTransactionPage> createState() => _AllTransactionPageState();
}

class _AllTransactionPageState extends State<AllTransactionPage> {
  @override
  Widget build(BuildContext context) {
    final transProvider = context.watch<Controller>().transactions;
    return Scaffold(
      body: FutureBuilder(
        future: context.read<Controller>().fetchTransactions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred'),
            );
          } else {
            return ListView.builder(
                itemCount: transProvider.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(title: Text(transProvider[index].description)));
                });
          }
        },
      ),
    );
  }
}
