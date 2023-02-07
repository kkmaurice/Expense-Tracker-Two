import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/transaction_controller.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: context.read<Controller>().fetchTransactions(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Expanded(
                          child: ListView.builder(
                            itemCount:
                                context.watch<Controller>().transactions.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: context
                                            .watch<Controller>()
                                            .transactions[index]
                                            .type ==
                                        'Income'
                                    ? Colors.green
                                    : Colors.red,
                                child: ListTile(
                                  leading: const Icon(Icons.money),
                                  title: Text(context
                                      .watch<Controller>()
                                      .transactions[index]
                                      .type),
                                  trailing: context.watch<Controller>().transactions[index].type == 'Expense'? Text('- Shs ${context.watch<Controller>().transactions[index].amount}'):Text('Shs ${context.watch<Controller>().transactions[index].amount}'),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            });
  }
}