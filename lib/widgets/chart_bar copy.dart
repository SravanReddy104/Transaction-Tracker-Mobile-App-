import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/getdatat.dart';

class ChartBar1 extends StatelessWidget {
  // final String label;
  // final double spendingAmount;
  // final double spendingPctOfTotal;

  // ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<Products>(context);
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Total Income ${transactions.incomet}",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'lib/assets/fonts/OpenSans-Regular.ttf',
                        fontStyle: FontStyle.italic,
                        fontSize: 15),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    "Total Expense ${transactions.expenset}",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'lib/assets/fonts/OpenSans-Regular.ttf',
                        fontStyle: FontStyle.italic,
                        fontSize: 15),
                  ),
                ],
              ),
              Text(
                "Food=${transactions.food}",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'lib/assets/fonts/OpenSans-Regular.ttf',
                    fontStyle: FontStyle.italic,
                    fontSize: 15),
              ),
              Text(
                "Shopping=${transactions.shopping}",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'lib/assets/fonts/OpenSans-Regular.ttf',
                    fontStyle: FontStyle.italic,
                    fontSize: 15),
              ),
              Text(
                "Education=${transactions.education}",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'lib/assets/fonts/OpenSans-Regular.ttf',
                    fontStyle: FontStyle.italic,
                    fontSize: 15),
              ),
              Text(
                "Retail=${transactions.retail}",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'lib/assets/fonts/OpenSans-Regular.ttf',
                    fontStyle: FontStyle.italic,
                    fontSize: 15),
              ),
            ],
          ),
        ]),
      ),
    );
    // FittedBox(
    //       // child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
    //       child: Text("${transactions.incomet}"),
    //     ),
    //   ),
    //   SizedBox(
    //     height: 4,
    //   ),
    //   Container(
    //       height: 60,
    //       width: 10,
    //       child: Stack(
    //         children: <Widget>[
    //           Container(
    //             decoration: BoxDecoration(
    //               border: Border.all(color: Colors.grey, width: 1.0),
    //               color: Color.fromRGBO(220, 220, 220, 1),
    //               borderRadius: BorderRadius.circular(10),
    //             ),
    // child: Column(
    //   children: [
    //     Row(
    //       children: [
    //         Text("Total Income ${transactions.incomet}"),
    //         Text("Total Expense ${transactions.expenset}")
    //       ],
    //     ),
    //     Text("F=${transactions.food}"),
    //     Text("S=${transactions.shopping}"),
    //     Text("E=${transactions.education}"),
    //     Text("R=${transactions.retail}")
    //   ],
    // ),
    //           ),
    //           SizedBox(
    //             height: 4,
    //           ),
    //           Text("${transactions.expenset}"),
    //         ],
    //       ))
    // ]);
  }
}
