import '../widgets/new_transaction.dart';

import '/models/transaction.dart';
import 'package:dailyapp/screens/analytics.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';

class Products with ChangeNotifier {
  final auth;
  final userid;
  var username;
  var incomet = 0;
  var expenset = 0;
  var retail = 0.0;
  var food = 0.0;
  var education = 0.0;
  var shopping = 0.0;
  var retailp = 0;
  var shoppingp = 0;
  var foodp = 0;
  var educationp = 0;
  List categoryp;
  String limit;
  String usermail;
  var number1;
  var _k;
  Products(this.auth, this.userid, this.username, this.limit, this.usermail);

  List<Transaction> _userTransactions = [];

  // var _showFavoritesOnly = false;

  List<Transaction> get userTransactions {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    // ignore: sdk_version_ui_as_code
    return [..._userTransactions];
  }

  List<Transaction> get _userexpenseTransactions {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    // ignore: sdk_version_ui_as_code
    _k = _userTransactions.where((k) => k.type == "Expense");
    return _k;
  }

  List<Transaction> get recentTransactions {
    return _userexpenseTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  // ignore: missing_return
  Future reset() {
    _userTransactions = [];
  }

  Future adduser(user) async {
    final url1 = Uri.parse(
        'https://minor-project-8f731-default-rtdb.firebaseio.com//username/$userid.json?auth=$auth');

    http.patch(url1, body: json.encode({'username': user}));
    username = user;
  }

  Future addlimit(limits) async {
    final url1 = Uri.parse(
        'https://minor-project-8f731-default-rtdb.firebaseio.com//limit/$userid.json?auth=$auth');

    http.patch(url1, body: json.encode({'limit': limits}));
    limit = limits;
  }

  Future addnumber(number) async {
    final url1 = Uri.parse(
        'https://minor-project-8f731-default-rtdb.firebaseio.com//phonenumber/$userid.json?auth=$auth');

    http.patch(url1, body: json.encode({'limit': number}));
    number1 = number;
  }

  void addNewTransaction(String category, String type, String txTitle,
      double txAmount, DateTime chosenDate) {
    print("the $_k");
    print(userTransactions);
    if (_userTransactions.isEmpty) {
      adduser(username);
      addlimit(limit);
    }

    final url = Uri.parse(
        'https://minor-project-8f731-default-rtdb.firebaseio.com//Transactions/$userid.json?auth=$auth');
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString(),
        type: type,
        category: category);

    _userTransactions.add(newTx);
    notifyListeners();
    // if (type == "Income") {
    //   incomet += txAmount as int;
    // }

    http.post(url,
        body: json.encode({
          'txtitle': txTitle,
          'txamount': txAmount,
          'chosendate': chosenDate.toString(),
          'category': category,
          'type': type,
          'limit': limit,
          // ignore: equal_keys_in_map
          'category': category,
          'username': username
        }));

    calc();
    notifyListeners();
  }

  void notifyListeners();

  void deleteTransaction(String id) {
    // final url = Uri.parse(
    //     'https://mini-bc48f-default-rtdb.firebaseio.com/Transactions.json');

    http.delete(Uri.parse(
        'https://minor-project-8f731-default-rtdb.firebaseio.com//Transactions/$userid/$id.json?auth=$auth'));
    notifyListeners();
    _userTransactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
    calc();
    notifyListeners();
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://minor-project-8f731-default-rtdb.firebaseio.com//Transactions/$userid.json?auth=$auth');
    final url1 = Uri.parse(
        'https://minor-project-8f731-default-rtdb.firebaseio.com//username/$userid.json?auth=$auth');
    final url2 = Uri.parse(
        'https://minor-project-8f731-default-rtdb.firebaseio.com//limit/$userid.json?auth=$auth');
    final url3 = Uri.parse(
        'https://minor-project-8f731-default-rtdb.firebaseio.com//phonenumber/$userid.json?auth=$auth');

    try {
      final response = await http.get(url);
      final response1 = await http.get(url1);
      final response2 = await http.get(url2);
      final response3 = await http.get(url3);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final extractedData3 =
          json.decode(response3.body) as Map<String, dynamic>;
      final extractedData1 =
          json.decode(response1.body) as Map<String, dynamic>;
      final extractedData2 =
          json.decode(response2.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      if (extractedData1 == null) {
        return;
      }
      if (extractedData2 == null) {
        return;
      }
      if (extractedData3 == null) {
        return;
      }
      limit = extractedData2['limit'];
      number1 = extractedData3['phonenumber'];

      final List<Transaction> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Transaction(
              id: prodId,
              title: prodData['txtitle'],
              amount: prodData['txamount'],
              date: DateTime.parse(prodData['chosendate']),
              type: prodData['type'],
              category: prodData['category']),
        );
      });
      _userTransactions = loadedProducts;
      notifyListeners();

      username = extractedData1['username'];
      print("the $_k");
      print(userTransactions);
      notifyListeners();

      calc();
    } catch (error) {
      throw (error);
    }
  }

  void calc() {
    categoryp = [];
    retailp = 0;
    shoppingp = 0;
    foodp = 0;
    educationp = 0;
    incomet = 0;
    expenset = 0;
    retail = 0;
    shopping = 0;
    food = 0;
    education = 0;

    for (var i = 0; i < userTransactions.length; i++) {
      if (userTransactions[i].type == 'Income') {
        incomet += userTransactions[i].amount as int;
      } else {
        expenset += userTransactions[i].amount as int;
      }
      if (userTransactions[i].category == "Retail") {
        retail += userTransactions[i].amount;
      } else if (userTransactions[i].category == "Shopping") {
        shopping += userTransactions[i].amount;
      } else if (userTransactions[i].category == "Food") {
        food += userTransactions[i].amount;
      } else if (userTransactions[i].category == "Education") {
        education += userTransactions[i].amount;
      }
    }

    Analytics();
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  // void addProduct() {

  //   notifyListeners();
  // }
}
