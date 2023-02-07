// ignore_for_file: use_build_context_synchronously

import 'package:date_format/date_format.dart';
import 'package:expens_tracker/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../view_model/transaction_controller.dart';
import 'main_page.dart';

class TransactionInput extends StatefulWidget {
  const TransactionInput({super.key});

  @override
  State<TransactionInput> createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  String? chooseValue;
  //TextEditingController _typeController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime? _picked;
  bool _isLoading = false;

  bool _isloading = false;

  @override
  void dispose() {
    //_typeController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  final List<String> _type = [
    'Income',
    'Expense',
  ];

   Future<void> _myDatePicker(BuildContext context) async{
   DateTime? _date = await showDatePicker(
        context: context, 
        initialDate: DateTime.now(), 
        firstDate: DateTime(2019), 
        lastDate: DateTime(2050));
    if (_date != null){
      setState(() {
        _picked = _date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 10, right: 10),
              height: MediaQuery.of(context).size.height * 0.20,
              color: Colors.greenAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const MainPage()));
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    'Add Transaction',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 50, bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.only( left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButton(
                          hint: const Text('Choose type'),
                          value: chooseValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 36,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: _type.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              chooseValue = newValue;
                            });
                          },
                          ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter amount',
                            
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                                _amountController.text = value;
                            _amountController.selection = TextSelection.fromPosition(TextPosition(offset: _amountController.text.length));
                            },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter description',
                          ),
                          onChanged: (value) {
                                _descriptionController.text = value;
                            _descriptionController.selection = TextSelection.fromPosition(TextPosition(offset: _descriptionController.text.length));
                            },
                        ),
                      ),
                    ),
                    //HERE IS JUST FOR TEST
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(_picked!=null? formatDate(_picked!, [MM,' ',d,', ',yyyy]): 'No date picked', style: const TextStyle(fontSize: 25),),
                    ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ElevatedButton.icon(
                    onPressed: () async{
                      await _myDatePicker(context);
                    }, 
                    icon: const Icon(Icons.calendar_month), 
                    label: const Text('Pick Date')),
                ),
                   _isloading? const Center(child: CircularProgressIndicator()) :
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () async{
                            setState(() {
                              _isloading = true;
                            });
                            await context.read<Controller>().addToDb( id: DateTime.now().toIso8601String(), 
                            type: chooseValue!, 
                            amount: double.parse(_amountController.text), 
                            description: _descriptionController.text, 
                            date: DateTime.now());
                           Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const MainPage()));
                            setState(() {
                              _isloading = false;
                              _descriptionController.clear();
                              _amountController.clear();
                              
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text('Add Transaction'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}