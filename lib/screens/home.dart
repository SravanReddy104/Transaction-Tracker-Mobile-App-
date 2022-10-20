import 'package:dailyapp/provider/getdatat.dart';
import 'package:dailyapp/screens/analytics.dart';

import 'package:dailyapp/screens/settings.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dailyapp/widgets/chart_bar%20copy.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/transaction_list.dart';

import '../provider/auth.dart';

import '../widgets/notify.dart';
import 'splashscreen.dart';

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // void initState() {

  //   Future.delayed(Duration.zero).then((value) {
  //     Provider.of<Products>(context).fetchAndSetProducts();
  //   });
  //   super.initState();
  // }

  Future didChangeDependencies() async {
    await Provider.of<Products>(context).fetchAndSetProducts();
    SplashScreen();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final usertaransaction = Provider.of<Products>(context);
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(
            " Hello ${usertaransaction.username}",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'lib/assets/fonts/OpenSans-Regular.ttf',
                fontStyle: FontStyle.italic,
                fontSize: 20),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => usertaransaction.startAddNewTransaction(context),
            ),
            // (usertaransaction.expenset > limit)
            //     ? Badge(
            //         badgeContent: Text('1'),
            //         child: IconButton(
            //           icon: Icon(
            //             Icons.notifications,
            //           ),
            //           onPressed: () => Navigator.of(context)
            //               .push(MaterialPageRoute(builder: (_) => Notifi())),
            //         ),
            //         shape: BadgeShape.circle,
            //       )
            //     : Badge(
            //         badgeContent: Text('0'),
            //         child: IconButton(
            //           icon: Icon(
            //             Icons.notifications,
            //           ),
            //           onPressed: () => Navigator.of(context)
            //               .push(MaterialPageRoute(builder: (_) => Notifi())),
            //         ),
            //         shape: BadgeShape.circle,
            //       ),
            // ignore: deprecated_member_use
            // (usertaransaction.limit is String)
            //     ? RaisedButton(
            //         child: Text("Enter Limit In Number At Settings"),
            //         onPressed: null,
            //       )
            IconButton(
              icon: Icon(Icons.notifications_active),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Notifi())),
            ),
            DropdownButton(
              underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.analytics, color: Colors.purpleAccent),
                        SizedBox(width: 8),
                        Text('Analytics'),
                      ],
                    ),
                  ),
                  value: 'Analytics',
                ),
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.logout_rounded,
                          color: Colors.purpleAccent,
                        ),
                        SizedBox(width: 8),
                        Text('logout'),
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
                // DropdownMenuItem(
                //   child: Container(
                //     child: Row(
                //       children: <Widget>[
                //         Icon(Icons.calculate, color: Colors.purpleAccent),
                //         SizedBox(width: 8),
                //         Text('Calculator'),
                //       ],
                //     ),
                //   ),
                //   value: 'caluclator',
                // ),
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.settings, color: Colors.purpleAccent),
                        SizedBox(width: 8),
                        Text('Settings'),
                      ],
                    ),
                  ),
                  value: 'settings',
                ),
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.settings, color: Colors.purpleAccent),
                        SizedBox(width: 8),
                        Text('Reset'),
                      ],
                    ),
                  ),
                  value: 'Reset',
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'Analytics') {
                  usertaransaction.userTransactions.isEmpty
                      ? CircularProgressIndicator()
                      : Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Analytics()));
                } else if (itemIdentifier == 'logout') {
                  auth.logout();
                } else if (itemIdentifier == 'calculator') {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (_) => Calculator()));
                } else if (itemIdentifier == 'settings') {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SettingsScreen()));
                } else if (itemIdentifier == 'Reset') {
                  usertaransaction.reset();
                }
              },
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            ChartBar1(),
            TransactionList(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => usertaransaction.startAddNewTransaction(context)),
    );
  }
}
