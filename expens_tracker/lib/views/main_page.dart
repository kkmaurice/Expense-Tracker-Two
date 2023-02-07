import 'package:expens_tracker/views/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'home.dart';
import 'transactions.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

    int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _pages = <Widget>[
    HomePage(),
    TransactionInput(),
    Transactions(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: _pages.elementAt(_selectedIndex),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          iconSize: 24,
          selectedFontSize: 13,
          unselectedItemColor: Colors.white,
          backgroundColor: Colors.blueAccent[400],
          selectedIconTheme: const IconThemeData(color: Colors.amberAccent, size: 30),
          selectedItemColor: Colors.amberAccent,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

      items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: 'Home',
        backgroundColor: Colors.deepOrange.shade900,
      ),
       BottomNavigationBarItem(
        icon: const Icon(Icons.add),
        label: 'Add',
        backgroundColor: Colors.grey.shade900.withOpacity(0.9),
      ),
       BottomNavigationBarItem(
        icon: const Icon(Icons.article),
        label: 'Transactions',
        backgroundColor: Colors.grey.shade900.withOpacity(0.9),
      ),
    ],
  ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _HomePageState extends State<MainPage> {

//   int _selectedIndex = 0;

//   void _onItemTapped(int index){
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//    List<Widget> _pages = <Widget>[
//   HomePage(),
//   // Container(
//   //   child: Center(
//   //     child: Text('This is the home page'),
//   //   ),
//   // ),
//   Container(
//     child: Center(
//       child: Text('This is the transactions page'),
//     ),
//     ),
//   Container(
//     color: Colors.red,
//   )
//   ];
  



//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         // appBar: AppBar(
//         //   title: const Text('PneumoScan',style: TextStyle(fontSize: 30),),
//         //   centerTitle: true,
//         //   automaticallyImplyLeading: true,
//         //   backgroundColor: const Color(0xFFf5641d),
//         //   elevation: 0,
//         // ),
//         body: _pages.elementAt(_selectedIndex),

//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//           elevation: 0,
//           type: BottomNavigationBarType.fixed,
//           showUnselectedLabels: true,
//           iconSize: 24,
//           selectedFontSize: 13,
//           unselectedItemColor: Colors.white,
//           backgroundColor: Colors.grey.shade900,
//           selectedIconTheme: const IconThemeData(color: Colors.amberAccent, size: 30),
//           selectedItemColor: Colors.amberAccent,
//           selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

//       items: <BottomNavigationBarItem>[
//       BottomNavigationBarItem(
//         icon: const Icon(Icons.home),
//         label: 'Home',
//         backgroundColor: Colors.deepOrange.shade900,
//       ),
//        BottomNavigationBarItem(
//         icon: const Icon(Icons.image),
//         label: 'X-ray',
//         backgroundColor: Colors.grey.shade900.withOpacity(0.9),
//       ),
//       //  BottomNavigationBarItem(
//       //   icon: const Icon(Icons.mic),
//       //   label: 'Recorder',
//       //   backgroundColor: Colors.grey.shade900.withOpacity(0.9),
//       // ),
//        BottomNavigationBarItem(
//         icon: const Icon(Icons.article),
//         label: 'Guide',
//         backgroundColor: Colors.grey.shade900.withOpacity(0.9),
//       ),
//     ],
//   ),
//       ),
//     );
//   }
// }

