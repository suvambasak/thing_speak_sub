import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thing_speak_sub/widgets/header.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:thing_speak_sub/util/storage.dart';

class TpSub extends StatefulWidget {
  @override
  _TpSubState createState() => _TpSubState();
}

class _TpSubState extends State<TpSub> {
  // Logos
  static const IconData defaultLogo = Icons.domain_verification_outlined;
  static const IconData dateLogo = Icons.date_range;
  static const IconData timeLogo = Icons.timer;

  List<String> keys = [
    'field1',
    'field2',
    'field3',
    'field4',
    'field5',
    'field6',
    'field7',
    'field8'
  ];

  late int len;
  late Map<String, dynamic> jsonResponse;
  late String time;
  late String date;
  bool status = false;

  @override
  void initState() {
    super.initState();
    loadData();
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
    components.add(SizedBox(height: 8.0));
    components.add(Heading(true));
    components.add(SubHeading('Subscribe'));
    components.add(SizedBox(height: 16.0));

    if (status) {
      components.add(cardBuilder(dateLogo, 'Data', date));
      components.add(cardBuilder(timeLogo, 'Time', time));

      for (int i = 0; i < len; i++) {
        components.add(cardBuilder(
            defaultLogo,
            jsonResponse['channel'][keys[i]],
            jsonResponse['feeds'][0][keys[i]]));
      }
    } else {
      components.add(Center(
          child: Padding(
        padding: const EdgeInsets.all(64.0),
        child: CircularProgressIndicator(),
      )));
    }

    return components;
  }

  // Fetch data.
  Future<void> loadData() async {
    // NEW

    SharedPreferences prefs = await SharedPreferences.getInstance();
    len = prefs.getInt(StorageKeys.FIELD_COUNT)!;
    String channelId = (prefs.getString(StorageKeys.CHANNEL_ID) ?? '1403127');
    print(len);
    print(channelId);

    final String url =
        'https://api.thingspeak.com/channels/${channelId}/feeds.json?results=1';
    print(url);

    http.Response response1 = await http.get(Uri.parse(url));
    if (response1.statusCode == 200) {
      setState(() {
        jsonResponse = jsonDecode(response1.body) as Map<String, dynamic>;
        date = jsonResponse['feeds'][0]['created_at'].split('T')[0];
        time =
            jsonResponse['feeds'][0]['created_at'].split('T')[1].split('Z')[0];
        status = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error while loading...'),
        ),
      );
    }
  }

  // Cards for showing data
  Widget cardBuilder(IconData logo, String heading, String state) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10.0,
      child: Column(
        children: [
          ListTile(
            leading: Icon(logo, color: Colors.black),
            title: Text(
              heading,
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            indent: 20.0,
            endIndent: 20.0,
            thickness: 3,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              state,
              textScaleFactor: 4,
              style: TextStyle(color: Colors.blueGrey.shade700),
            ),
          ),
          SizedBox(
            height: 3,
          )
        ],
      ),
    );
  }

  // Floating action button for reload data.
  Widget reload() {
    return FloatingActionButton.extended(
      elevation: 10.0,
      onPressed: loadData,
      icon: Icon(Icons.update),
      label: Text('Update'),
      backgroundColor: Colors.red,
    );
  }
}
