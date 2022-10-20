import 'package:dailyapp/provider/auth.dart';
import 'package:dailyapp/provider/getdatat.dart';
import 'package:dailyapp/screens/auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var update;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: null,
            update: (ctx, auth, previousOrders) => Products(auth.token,
                auth.userId, auth.username, auth.limit, auth.usermail),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Personal Expenses',
            theme: ThemeData(
              fontFamily: 'Quicksand',
              textTheme: ThemeData.light().textTheme.copyWith(
                    // ignore: deprecated_member_use
                    subtitle1: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    button: TextStyle(color: Colors.white),
                  ),
              appBarTheme: AppBarTheme(
                toolbarTextStyle: ThemeData.light()
                    .textTheme
                    .copyWith(
                      // ignore: deprecated_member_use
                      subtitle1: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    .bodyText2,
                titleTextStyle: ThemeData.light()
                    .textTheme
                    .copyWith(
                      // ignore: deprecated_member_use
                      subtitle1: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    .headline6,
              ),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                  .copyWith(secondary: Colors.amber),
            ),

            home: auth.isAuth ? MyHomePage() : AuthScreen(),

            //auth.isAuth ? MyHomePage() : AuthScreen()
            routes: {},
          ),
        ));
  }
}
