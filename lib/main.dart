import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import './models/transaction.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses Checker',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
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
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _useTransactions = [
    Transaction(
      id: 't1',
      title: 'fix old shose',
      amount: 500,
      date: DateTime.now().subtract(
        Duration(
          days: 3,
        ),
      ),
    ),
    Transaction(
      id: 't2',
      title: 'new shose',
      amount: 3500,
      date: DateTime.now().subtract(
        Duration(
          days: 5,
        ),
      ),
    ),
    Transaction(
      id: 't3',
      title: 'new shose',
      amount: 3500,
      date: DateTime.now().subtract(
        Duration(
          days: 5,
        ),
      ),
    ),
    Transaction(
      id: 't4',
      title: 'new shose',
      amount: 3500,
      date: DateTime.now().subtract(
        Duration(
          days: 5,
        ),
      ),
    ),
    Transaction(
      id: 't5',
      title: 'new shose',
      amount: 3500,
      date: DateTime.now().subtract(
        Duration(
          days: 5,
        ),
      ),
    ),
    Transaction(
      id: 't6',
      title: 'new shose',
      amount: 3500,
      date: DateTime.now().subtract(
        Duration(
          days: 5,
        ),
      ),
    ),
    Transaction(
      id: 't7',
      title: 'new shose',
      amount: 3500,
      date: DateTime.now().subtract(
        Duration(
          days: 5,
        ),
      ),
    ),
  ];
  bool _showChart = false;
  List<Transaction> get recentTransactionList {
    return _useTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(
            days: 7,
          ),
        ),
      );
    }).toList();
  }

  void addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _useTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _useTransactions.removeWhere((element) => element.id == id);
    });
  }

  void showAddTransactionInputs(ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          child: NewTransaction(addNewTransaction),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Expenses Checker'),
      actions: [
        IconButton(
          onPressed: () => showAddTransactionInputs(context),
          icon: Icon(
            Icons.add,
          ),
        ),
      ],
    );

    final _mediaQuery = MediaQuery.of(context);

    final txListWidget = Container(
      height: (_mediaQuery.size.height -
              appBar.preferredSize.height -
              _mediaQuery.padding.top) *
          0.8,
      child: TransactionList(
        _useTransactions,
        _deleteTransaction,
      ),
    );
    final isLandscape = _mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'show charts',
                  ),
                  Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                      print(value);
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (_mediaQuery.size.height -
                        appBar.preferredSize.height -
                        _mediaQuery.padding.top) *
                    0.2,
                child: Chart(recentTransactionList),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (_mediaQuery.size.height -
                              appBar.preferredSize.height -
                              _mediaQuery.padding.top) *
                          0.7,
                      child: Chart(recentTransactionList),
                    )
                  : txListWidget,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTransactionInputs(context),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
