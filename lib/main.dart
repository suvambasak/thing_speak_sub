import 'package:flutter/material.dart';

class TpSub extends StatefulWidget {
  @override
  _TpSubState createState() => _TpSubState();
}

class _TpSubState extends State<TpSub> {
  static const IconData dateLogo = Icons.date_range;
  static const IconData timeLogo = Icons.timer;
  static const IconData temperatureLogo = Icons.thermostat;
  static const IconData humidityLogo = Icons.air;

  Data currentSate = Data();

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
                cardBuilder(dateLogo, 'Data', currentSate.date),
                cardBuilder(timeLogo, 'Time', currentSate.time),
                cardBuilder(
                    temperatureLogo, 'Temperature', currentSate.temperature),
                cardBuilder(humidityLogo, 'Humidity', currentSate.humidity),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  Widget reload() {
    return FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.update),
      backgroundColor: Colors.redAccent,
    );
  }
}

class Data {
  String date = '2021-05-11';
  String time = '13:28:53';
  String temperature = '32';
  String humidity = '54%';
}

void main() => runApp(TpSub());
