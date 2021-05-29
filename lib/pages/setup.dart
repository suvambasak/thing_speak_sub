import 'package:flutter/material.dart';

import '../head/header.dart';

class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
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
            SizedBox(
              height: 20.0,
            ),
            Form(
              child: setForm(),
            )
          ],
        ),
      ),
    );
  }

  Column setForm() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Channel ID',
            hintText: 'Your Chennel ID (Eg: 1385093)',
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Total Field',
            hintText: 'Field#: (Eg: 2)',
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/sub');
          },
          child: Text('Save'),
          style: TextButton.styleFrom(minimumSize: Size(100.0, 40.0)),
        ),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
