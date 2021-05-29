import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thing_speak_sub/util/storage.dart';

class Header {
  void _clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(StorageKeys.CHANNEL_ID);
    prefs.remove(StorageKeys.FIELD_COUNT);
    prefs.remove(StorageKeys.SAVE_STATUS);
  }

  Widget getHeader(bool logout) {
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
          logout
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

  Widget getSubHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 110.0, right: 8.0),
      child: Text(
        text,
        textScaleFactor: 1.5,
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
