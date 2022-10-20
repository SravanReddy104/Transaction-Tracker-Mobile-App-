import 'package:dailyapp/provider/getdatat.dart';
import 'package:dailyapp/widgets/chart.dart';

// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';
import 'package:provider/provider.dart';
import '../widgets/chartincome.dart';

class Analytics extends StatefulWidget {
  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Products>(context);
    var sum = user.retail + user.shopping + user.food + user.education;
    var retailp = ((user.retail / sum) * 100);

    var foodp = (user.food / sum) * 100;

    var educationp = (user.education / sum) * 100;
    var shoppingp = (user.shopping / sum) * 100;

    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Analytics Of Transactions",
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'lib/assets/fonts/OpenSans-Bold.ttf',
            fontStyle: FontStyle.italic,
            fontSize: 20),
        textAlign: TextAlign.center,
      )),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            Container(
                height: 50,
                width: 20,
                child: Card(
                  borderOnForeground: true,
                  child: Center(
                    child: Text(
                      "Bar Chart Of Week Transactions (Expense)",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  color: Colors.purple.withOpacity(0.5),
                )),
            Chart(user.userTransactions),
            Container(
                height: 50,
                width: 20,
                child: Card(
                  borderOnForeground: true,
                  child: Center(
                    child: Text(
                      "Bar Chart Of Week Transactions (Income)",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  color: Colors.purple.withOpacity(0.5),
                )),
            ChartIncome(user.userTransactions),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: 20,
              child: Card(
                borderOnForeground: true,
                child: Center(
                  child: Text(
                    "Pie Chart Of Transactions (Categories)",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color: Colors.purple.withOpacity(0.4),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              child: Center(
                child: Container(
                  height: 300,
                  width: 500,
                  child: PieChart(
                    values: [
                      educationp.floorToDouble(),
                      retailp.floorToDouble(),
                      foodp.floorToDouble(),
                      shoppingp.floorToDouble(),
                    ],
                    labels: ["Education", "Retail", "Food", "Shopping"],
                    sliceFillColors: [
                      Colors.blueAccent,
                      Colors.greenAccent,
                      Colors.pink,
                      Colors.orange,
                    ],

                    size: Size.square(400),

                    // animationDuration: Duration(milliseconds: 1500),
                    animate: false,
                    legendPosition: LegendPosition.Right,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
