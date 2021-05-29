import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thing_speak_sub/data.dart';
import 'package:thing_speak_sub/head/header.dart';

class TpSub extends StatefulWidget {
  @override
  _TpSubState createState() => _TpSubState();
}

class _TpSubState extends State<TpSub> {
  // URL
  static const String dataURL =
      'https://api.thingspeak.com/channels/1385704/feeds.json?results=1';

  // Logos
  static const IconData dateLogo = Icons.date_range;
  static const IconData timeLogo = Icons.timer;
  static const IconData temperatureLogo = Icons.thermostat;
  static const IconData humidityLogo = Icons.air;

  // Current data.
  Data currentState = Data();

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
    Header header = Header();
    List<Widget> components = [];
    components.add(SizedBox(height: 8.0));
    components.add(header.getHeader());
    components.add(header.getSubHeader('Subscribe'));
    components.add(SizedBox(height: 16.0));

    if (currentState.isloaded) {
      components.add(cardBuilder(dateLogo, 'Data', currentState.date));
      components.add(cardBuilder(timeLogo, 'Time', currentState.time));
      components.add(cardBuilder(
          temperatureLogo, 'Temperature', currentState.temperature));
      components
          .add(cardBuilder(humidityLogo, 'Humidity', currentState.humidity));
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
        currentState.setLoaded();
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

  // Heading
  // Widget appHeader() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 8.0, right: 8.0),
  //     child: Text(
  //       'ThingSpeak',
  //       textScaleFactor: 2.5,
  //       style: TextStyle(
  //         color: Colors.blue,
  //         fontWeight: FontWeight.w900,
  //       ),
  //     ),
  //   );
  // }

  // Sub heading
  // Widget appSubHeader(String text) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 110.0, right: 8.0),
  //     child: Text(
  //       text,
  //       textScaleFactor: 1.5,
  //       style: TextStyle(
  //         color: Colors.green,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //   );
  // }

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
