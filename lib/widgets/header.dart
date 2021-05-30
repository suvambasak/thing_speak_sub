import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thing_speak_sub/util/storage.dart';

// ignore: must_be_immutable
class Heading extends StatelessWidget {
  late bool logoutButton;

  Heading(this.logoutButton);

  void _clearData() async {
    print('logout button pressed');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(StorageKeys.SAVE_STATUS, false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        children: [
          Text(
            'ThingSpeak',
            textScaleFactor: 2.5,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w900,
            ),
          ),
          Spacer(),
          logoutButton
              ? Column(
                  children: [
                    IconButton(
                      onPressed: _clearData,
                      tooltip: 'Set new channel',
                      icon: const Icon(Icons.logout),
                    ),
                    Text('Exit'),
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SubHeading extends StatelessWidget {
  String title;
  SubHeading(this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 110.0, right: 8.0),
      child: Text(
        title,
        textScaleFactor: 1.5,
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
