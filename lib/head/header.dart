import 'package:flutter/material.dart';

class Header {
  Widget getHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Text(
        'ThingSpeak',
        textScaleFactor: 2.5,
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w900,
        ),
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
