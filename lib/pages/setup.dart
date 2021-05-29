import 'package:flutter/material.dart';

import '../head/header.dart';

class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  Header header = Header();
  final _dataFrom = GlobalKey<FormState>();
  final channelTextController = TextEditingController();
  final fieldTextController = TextEditingController();

  void _saveData() async {
    if (_dataFrom.currentState!.validate()) {
      print('Valid');
      print(channelTextController.text);
      print(fieldTextController.text);
    } else {
      print('Invalid');
    }
    // Navigator.pushNamed(context, '/sub');
  }

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
              key: _dataFrom,
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
          controller: channelTextController,
          decoration: InputDecoration(
            labelText: 'Channel ID',
            hintText: 'Your Chennel ID (Eg: 1385093)',
          ),
          validator: (value) {
            if (value!.isEmpty) return 'Channel ID cannot be empty!';
            return null;
          },
        ),
        SizedBox(
          height: 5.0,
        ),
        TextFormField(
          controller: fieldTextController,
          decoration: InputDecoration(
            labelText: 'Total Field',
            hintText: 'No of Field: (Eg: 2)',
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) return 'No of Field cannot be empty!';
            return null;
          },
        ),
        SizedBox(
          height: 15.0,
        ),
        ElevatedButton(
          onPressed: _saveData,
          // onPressed: () {
          //   Navigator.pushNamed(context, '/sub');
          // },
          child: Text('Save'),
          style: TextButton.styleFrom(minimumSize: Size(100.0, 40.0)),
        ),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    channelTextController.dispose();
    fieldTextController.dispose();
    super.dispose();
  }
}
