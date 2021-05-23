import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TpSub extends StatefulWidget {
  @override
  _TpSubState createState() => _TpSubState();
}

class _TpSubState extends State<TpSub> {
  // URL
  static const String dataURL =
      'https://api.thingspeak.com/channels/1385093/feeds.json?results=1';

  // Logos
  static const IconData dateLogo = Icons.date_range;
  static const IconData timeLogo = Icons.timer;
  static const IconData temperatureLogo = Icons.thermostat;
  static const IconData humidityLogo = Icons.air;

  // Current data.
  Data currentState = Data();

  // Fetch data.
  Future<void> loadData() async {
    http.Response response = await http.get(Uri.parse(dataURL));
    // print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          jsonDecode(response.body) as Map<String, dynamic>;

      // print(jsonResponse['feeds'][0]['created_at'].split('T')[0]);
      // print(jsonResponse['feeds'][0]['created_at'].split('T')[1].split('Z')[0]);
      // print(jsonResponse['feeds'][0]['field1']);
      // print(jsonResponse['feeds'][0]['field2']);

      setState(() {
        currentState.date =
            jsonResponse['feeds'][0]['created_at'].split('T')[0];
        currentState.time =
            jsonResponse['feeds'][0]['created_at'].split('T')[1].split('Z')[0];
        currentState.temperature = jsonResponse['feeds'][0]['field1'];
        currentState.humidity = jsonResponse['feeds'][0]['field2'];
      });
    } else {
      print('Error');
    }

    // setState(() {
    //   widgets = jsonDecode(response.body);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThingSpeak Subscribe',
      home: Scaffold(
        floatingActionButton: reload(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 8.0),
                appHeader(),
                appSubHeader(),
                SizedBox(height: 16.0),
                cardBuilder(dateLogo, 'Data', currentState.date),
                cardBuilder(timeLogo, 'Time', currentState.time),
                cardBuilder(
                    temperatureLogo, 'Temperature', currentState.temperature),
                cardBuilder(humidityLogo, 'Humidity', currentState.humidity),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Cards for showing data
  Widget cardBuilder(IconData logo, String heading, String state) {
    return Card(
      elevation: 10.0,
      child: Column(
        children: [
          ListTile(
            leading: Icon(logo, color: Colors.black),
            title: Text(
              heading,
              style: TextStyle(color: Colors.blue),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              state,
              textScaleFactor: 4,
            ),
          ),
        ],
      ),
    );
  }

  // Heading
  Widget appHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Text(
        'ThingSpeak',
        textScaleFactor: 2.5,
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Sub heading
  Widget appSubHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 110.0, right: 8.0),
      child: Text(
        'Subscribe',
        textScaleFactor: 1.5,
        style: TextStyle(
          color: Colors.green,
        ),
      ),
    );
  }

  // Floating action button for reload data.
  Widget reload() {
    return FloatingActionButton(
      elevation: 10.0,
      onPressed: loadData,
      child: Icon(Icons.update),
      backgroundColor: Colors.red,
    );
  }
}

class Data {
  String date = '0000-00-00';
  String time = '00:00:00';
  String temperature = '00';
  String humidity = '00';
}

void main() => runApp(TpSub());
