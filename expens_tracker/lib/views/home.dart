import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/transaction_controller.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bool _isAllExpense = false;
  bool _isRecent = true;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height * 0.40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 179, 198, 231),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(),
                      const Text('September'),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Total Balance',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                 Text(
                  'Shs ${context.watch<Controller>().totalBalance}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 80,
                        width: 150,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Income',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Text(
                                '\Shs ${context.watch<Controller>().totalIncome.toString()}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300)
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 150,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Expenses',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Text(
                                '\Shs ${context.watch<Controller>().totalExpense.toString()}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300)
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isRecent = true;
                    });
                  },
                  child: Chip(
                    label: Text('Recent Transactions'),
                    backgroundColor: _isRecent
                        ? Colors.blue
                        : Colors.grey,),
                ),
                
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isRecent = false;
                    });
                    print('tapped');
                  },
                  child: Chip(
                    label: const Text('Expenses'),
                    backgroundColor: _isRecent == false
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
              future: _isRecent
                  ? context.read<Controller>().fetchTransactions()
                  : context.read<Controller>().fetchTransactionsByItsType(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Expanded(
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
                                    .transactions[index].description
                                ),
                                trailing: context.watch<Controller>().transactions[index].type == 'Expense'? Text('- Shs ${context.watch<Controller>().transactions[index].amount}'):Text('Shs ${context.watch<Controller>().transactions[index].amount}'),
                              ),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              })
        ],
      )),
    );
  }
}
