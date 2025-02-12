import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amberAccent,
        fontFamily: 'QuickSand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  
  // String textInput;
  // String amountInput;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions =[
    // Transaction(id: 't1', title: 'Mobile Recharge', amount: 450 , date: DateTime.now()),
    // Transaction(id: 't2', title: 'Watch', amount: 4500 , date: DateTime.now()),
   ];

   List<Transaction> get _recentTransactions{
     return _userTransactions.where((tx){
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7)
          ),
        );
     }).toList();
   }

   void _addNewTransaction(String txTitle, double txAmount, DateTime txDate){
     final newTx = Transaction(id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txDate);

     setState(() {
       _userTransactions.add(newTx);
     });
   }


  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx,
     builder: (_) {
       return GestureDetector(child: NewTransaction(_addNewTransaction),
       onTap: (){},
       behavior: HitTestBehavior.opaque,
       );
     });
  }

  void _deleteTxn(String id){
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Expenses Tracker'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add_circle), onPressed: () => _startAddNewTransaction(context))
        ],
      ),
      body:  Column(
      
         
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          Chart(_recentTransactions),
           TransactionList(_userTransactions, _deleteTxn),
          ],
        
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context)),
    );
  }
}