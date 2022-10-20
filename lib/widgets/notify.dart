import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../provider/getdatat.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class Notifi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tn = Provider.of<Products>(context);
    int limit = int.parse(tn.limit);
    DateTime date = DateTime.now();

    var rem = tn.expenset - limit;
    Future send() async {
      final Email email = Email(
        body: 'Email body',
        subject: 'Email subject',
        recipients: ['myakalasravan56@gmail.com'],
        // cc: ['cc@example.com'],
        // bcc: ['bcc@example.com'],
        attachmentPaths: ['/path/to/attachment.zip'],
        isHTML: false,
      );

      await FlutterEmailSender.send(email);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notications Based on Provided Limit",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'lib/assets/fonts/OpenSans-Regular.ttf',
              fontStyle: FontStyle.italic,
              fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              child: (tn.expenset > limit)
                  ?
                  ListTile(
                      leading: ClipRect(
                        clipBehavior: Clip.hardEdge,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text('Cossed Rs$rem'),
                          ),
                        ),
                      ),
                      title: Text(
                        'Amount Crosed Your Limit',
                        // ignore: deprecated_member_use
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'lib/assets/fonts/OpenSans-Regular.ttf',
                            fontStyle: FontStyle.italic,
                            fontSize: 20),
                      ),
                      subtitle: Text('${DateFormat.yMd().format(date)}'),
                      trailing: Text(
                        'Reset Limit At Settings',
                        // ignore: deprecated_member_use
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'lib/assets/fonts/OpenSans-Regular.ttf',
                            fontStyle: FontStyle.italic,
                            fontSize: 20),
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        Text(
                          'No Notifcations', textAlign: TextAlign.center,
                          // ignore: deprecated_member_use
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            height: 200,
                            child: Image.asset('lib/screens/preview.jpg'),
                          ),
                        ),
                      ],
                    )),
        ),
      ),
    );
  }
}
