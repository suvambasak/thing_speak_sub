import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thing_speak_sub/util/data.dart';
import 'package:thing_speak_sub/widgets/components.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:thing_speak_sub/util/storage.dart';

class TpSub extends StatefulWidget {
  @override
  _TpSubState createState() => _TpSubState();
}

class _TpSubState extends State<TpSub> {
  // Logos
  static const IconData defaultLogo = Icons.mark_chat_read_outlined;
  static const IconData dateLogo = Icons.date_range;
  static const IconData timeLogo = Icons.timer;

  late int len;
  late Map<String, dynamic> jsonResponse;
  late final String url;
  Data currentData = Data();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: reload(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
            top: 16.0,
            bottom: 70.0,
            left: 16.0,
            right: 16.0,
          ),
          children: body(),
        ),
      ),
    );
  }

  // UI build
  List<Widget> body() {
    List<Widget> components = [];

    // Heading & ssub heading
    components.add(SizedBox(height: 8.0));
    components.add(Heading(true));
    components.add(SubHeading('Subscribe'));
    components.add(SizedBox(height: 16.0));

    if (currentData.status) {
      // Date and time card
      components.add(CardBuilder(dateLogo, 'Data', currentData.date));
      components.add(CardBuilder(timeLogo, 'Time', currentData.time));

      // all data card
      for (int i = 0; i < len && i < 8; i++) {
        if (null != jsonResponse['channel'][Data.keys[i]])
          components.add(CardBuilder(
              defaultLogo,
              jsonResponse['channel'][Data.keys[i]],
              jsonResponse['feeds'][0][Data.keys[i]]));
      }
    } else {
      // Data being loaded
      components.add(
        Center(
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return components;
  }

  // Fetch data from cloud
  Future<void> _loadData() async {
    // get channel id and number of field
    if (!currentData.status) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      len = prefs.getInt(StorageKeys.FIELD_COUNT)!;
      String channelId = (prefs.getString(StorageKeys.CHANNEL_ID) ?? '1403127');

      url =
          'https://api.thingspeak.com/channels/${channelId}/feeds.json?results=1';
    }

    // http request
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        // parse JSON
        jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

        // set data
        currentData.date = jsonResponse['feeds'][0]['created_at'].split('T')[0];
        currentData.time =
            jsonResponse['feeds'][0]['created_at'].split('T')[1].split('Z')[0];

        currentData.setLoaded();
      });
    } else {
      // error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error while loading...'),
        ),
      );
    }
  }

  // Floating action button for reload data.
  Widget reload() {
    return FloatingActionButton.extended(
      elevation: 10.0,
      onPressed: _loadData,
      icon: Icon(Icons.update),
      label: Text('Update'),
      backgroundColor: Colors.red,
    );
  }
}
