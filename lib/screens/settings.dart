// import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/getdatat.dart';

// class Settings extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final transactions = Provider.of<Products>(context);
//     return Scaffold(
//         appBar: AppBar(title: Text("settings")),
//         body: Center(
//             child: Card(
//           color: Colors.purpleAccent,
//           elevation: 5,
//           child: Container(
//               height: 300,
//               width: 500,
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: <Widget>[
//                   Center(
//                       child: Text(
//                     "USERNAME :  ${transactions.username}",
//                     style: TextStyle(fontSize: 20),
//                   ))
//                 ],
//               )),
//         )));
//   }
// }
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Settings UI',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'lib/assets/fonts/OpenSans-Regular.ttf',
            fontStyle: FontStyle.italic,
            fontSize: 15),
      )),
      body: buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    var _namecontroller;
    final transactions = Provider.of<Products>(context);

    var user = transactions.username;
    var limit = transactions.limit;
    var number = transactions.number1;
    if (number == null) {
      number = 0;
    }

    void resetuser() {
      transactions.adduser(user);
      Navigator.of(context).pop();
    }

    void resetlimit() {
      transactions.addlimit(limit);
      Navigator.of(context).pop();
    }

    return SettingsList(
      sections: [
        SettingsSection(
          title: Text('Common'),
          tiles: [
            SettingsTile(
              title: Text('Username  = $user'),
              leading: Icon(Icons.language),
              description: Text("Click To Change Username",
                  style: TextStyle(color: Colors.purpleAccent)),
              onPressed: (context) {
                showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          TextField(
                              decoration: InputDecoration(
                                  labelText: 'Enter New Username'),
                              controller: _namecontroller,
                              onChanged: (value) {
                                user = value;
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            child: Text('submit'),
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).textTheme.button.color,
                            onPressed: () => resetuser(),
                          ),
                        ],
                      ),
                      behavior: HitTestBehavior.opaque,
                    );
                  },
                );
              },
            ),
            SettingsTile(
              title: Text('Limit  = ${transactions.limit}'),
              leading: Icon(Icons.language),
              description: Text("Click To Change Limit",
                  style: TextStyle(color: Colors.purpleAccent)),
              onPressed: (context) {
                showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          TextField(
                              decoration:
                                  InputDecoration(labelText: 'Enter New Limit'),
                              controller: _namecontroller,
                              onChanged: (value) {
                                limit = value;
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            child: Text('submit'),
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).textTheme.button.color,
                            onPressed: () => resetlimit(),
                          ),
                        ],
                      ),
                      behavior: HitTestBehavior.opaque,
                    );
                  },
                );
              },
            ),
          ],
        ),
        SettingsSection(
          title: Text('Account'),
          tiles: [
            //     SettingsTile(
            //       title: Text('Set Phone Number = $number'),
            //       leading: Icon(Icons.language),
            //       description: Text("Click To Change Username",
            //           style: TextStyle(color: Colors.purpleAccent)),
            //       onPressed: (context) {
            //         showModalBottomSheet(
            //           context: context,
            //           builder: (_) {
            //             return GestureDetector(
            //               onTap: () {},
            //               child: Column(
            //                 children: [
            //                   TextField(
            //                       decoration:
            //                           InputDecoration(labelText: 'Phone Number'),
            //                       controller: _namecontroller,
            //                       onChanged: (value) {
            //                         user = value;
            //                       }),
            //                   SizedBox(
            //                     height: 10,
            //                   ),
            //                   // ignore: deprecated_member_use
            //                   RaisedButton(
            //                     child: Text('submit'),
            //                     color: Theme.of(context).primaryColor,
            // //                     textColor: Theme.of(context).textTheme.button.color,
            //                     onPressed: () => addnumber,
            //                   ),
            //                 ],
            //               ),
            //               behavior: HitTestBehavior.opaque,
            //             );
            //           },
            //         );
            //       },
            //     ),
            SettingsTile(
                title: Text('Email = ${transactions.usermail}'),
                leading: Icon(Icons.email)),
            SettingsTile(
                title: Text('Sign out'),
                leading: Icon(Icons.exit_to_app),
                onPressed: null),
          ],
        ),
        SettingsSection(
          title: Text('Security'),
          tiles: [
            SettingsTile.switchTile(
              title: Text('Limit  = ${transactions.limit}'),
              leading: Icon(Icons.phonelink_lock),
              onToggle: (bool value) {
                setState(() {
                  lockInBackground = value;
                  notificationsEnabled = value;
                });
              },
              initialValue: null,
            ),
            SettingsTile.switchTile(
              title: Text('Change password'),
              leading: Icon(Icons.lock),
              onToggle: (bool value) {},
              initialValue: false,
            ),
            SettingsTile.switchTile(
              title: Text('Enable Notifications'),
              enabled: notificationsEnabled,
              leading: Icon(Icons.notifications_active),
              initialValue: false,
              onToggle: (value) {},
            ),
          ],
        ),
        SettingsSection(
          title: Text('Misc'),
          tiles: [
            SettingsTile(
                title: Text('Terms of Service'),
                leading: Icon(Icons.description)),
            SettingsTile(
                title: Text('Open source licenses'),
                leading: Icon(Icons.collections_bookmark)),
          ],
        ),
      ],
    );
  }
}
