import 'package:Sample_Project/components/chart.dart';
import 'package:Sample_Project/components/new_transaction.dart';
import 'package:Sample_Project/components/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/transaction.dart';
import 'dart:io';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.amber),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(
                color: Colors.white,
              ),
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 'IPHN', title: 'iPhone 11 Pro', amount: 1499, date: DateTime.now()),
    Transaction(
        id: 'GCC', title: 'Gucci Guilty', amount: 999, date: DateTime.now()),
    Transaction(
        id: 'GCC', title: 'Nike x Supreme', amount: 299, date: DateTime.now()),
    Transaction(
        id: 'GCC', title: 'Home Pod', amount: 499, date: DateTime.now()),
  ];

  bool showChart = false;

  List<Transaction> get recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final _newTransaction = Transaction(
        title: txTitle, amount: txAmount, date: txDate, id: txDate.toString());

    setState(() {
      _userTransactions.add(_newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 15.0),
            child: NewTransaction(
              onPressedCallback: _addNewTransaction,
            ),
          ),
        );
      },
    );
  }

  void _deleteTransaction(int position) {
    setState(() {
      _userTransactions.removeAt(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final applicationBody = SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Show Chart',
                  style: TextStyle(fontFamily: 'Quicksand', fontSize: 18.0),
                ),
                if (isLandscape)
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    onChanged: (val) {
                      setState(() {
                        showChart = val;
                      });
                    },
                    value: showChart,
                  ),
              ],
            ),
          if (!isLandscape) Chart(recentTransactions),
          if (!isLandscape)
            Expanded(
              child: TransactionList(
                transactions: _userTransactions,
                onPressedCallback: _deleteTransaction,
              ),
            ),
          if (isLandscape)
            showChart
                ? Chart(recentTransactions)
                : Expanded(
                    child: TransactionList(
                      transactions: _userTransactions,
                      onPressedCallback: _deleteTransaction,
                    ),
                  ),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
             middle: Text('Expense Tracker',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _startAddNewTransaction(context),
                    child: Icon(CupertinoIcons.add),
                  ),
                ],
              ),
            ),
            child: applicationBody,
          )
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      _startAddNewTransaction(context);
                    },
                    child: Icon(Icons.add),
                  ),
            appBar: AppBar(
              title: Text(
                'Expense Tracker',
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _startAddNewTransaction(context);
                  },
                ),
              ],
            ),
            body: applicationBody,
          );
  }
}
