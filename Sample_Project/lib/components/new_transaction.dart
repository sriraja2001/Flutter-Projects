import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class NewTransaction extends StatefulWidget {
  final Function onPressedCallback;

  NewTransaction({this.onPressedCallback});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.onPressedCallback(enteredTitle, enteredAmount, _selectedDate);
    Navigator.pop(context);
  }

  void _presentDatePicker(BuildContext ctx) {
    showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      print(pickedDate.toIso8601String());
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              onSubmitted: (_) => _submitData(),
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
            ),
            TextField(
              onSubmitted: (_) => _submitData(),
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            Container(
              height: 70.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _selectedDate == null
                        ? 'No Date Chosen'
                        : 'Picked date : ${DateFormat.yMd().format(_selectedDate)}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _presentDatePicker(context);
                    },
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Platform.isIOS
                ? CupertinoButton(
                    child: Text('Add Transaction'),
                    onPressed: _submitData,
                    color: Theme.of(context).primaryColor,
                  )
                : FlatButton(
                    child: Text(
                      'Add Transaction',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.button.color,
                        fontSize: 20.0,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: _submitData,
                  )
          ],
        ),
      ),
    );
  }
}
