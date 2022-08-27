import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _addtransaction() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedDate == null) {
      return;
    }
    final enterdTitle = _titleController.text;
    final enterdAmout = double.parse(_amountController.text);
    widget.addNewTransaction(
      enterdTitle,
      enterdAmout,
      _selectedDate as DateTime,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: _mediaQuery.viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _addtransaction(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _addtransaction(),
              ),
              Container(
                height: 50,
                child: Row(children: [
                  Expanded(
                    child: Text(
                      (_selectedDate == null)
                          ? 'No Date Chosen!'
                          : 'Picked date  ${DateFormat.yMd().format(_selectedDate as DateTime).toString()}',
                    ),
                  ),
                  TextButton(
                    child: Text('chose date'),
                    onPressed: _presentDatePicker,
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColorDark),
                  ),
                ]),
              ),
              RaisedButton(
                onPressed: _addtransaction,
                child: Text(
                  'Add transaction',
                ),
                textColor: Theme.of(context).bottomAppBarColor,
                color: Theme.of(context).primaryColorDark,
              )
            ],
          ),
        ),
      ),
    );
  }
}
