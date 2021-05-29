import 'package:flutter/material.dart';

import '../head/header.dart';

class Setup extends StatelessWidget {
  Header header = Header();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
            top: 16.0,
            bottom: 70.0,
            left: 16.0,
            right: 16.0,
          ),
          children: [
            header.getHeader(),
            header.getSubHeader('Setup'),
          ],
        ),
      ),
    );
  }

  // // Heading
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
}
