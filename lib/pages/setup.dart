import 'package:flutter/material.dart';
import 'package:thing_speak_sub/util/storage.dart';

import '../widgets/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  // from key
  final _dataFrom = GlobalKey<FormState>();
  // input field controller
  final channelTextController = TextEditingController();
  final fieldTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    changePage();
  }

  // chnage page if data saved
  void changePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? status = prefs.getBool(StorageKeys.SAVE_STATUS);
    if (status != null && status) Navigator.pushNamed(context, '/sub');
  }

  // save data and change page
  void _saveData() async {
    if (_dataFrom.currentState!.validate()) {
      print('Valid');

      // save data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(StorageKeys.CHANNEL_ID, channelTextController.text);
      prefs.setInt(
          StorageKeys.FIELD_COUNT, int.parse(fieldTextController.text));
      prefs.setBool(StorageKeys.SAVE_STATUS, true);

      // change page
      Navigator.pushNamed(context, '/sub');
    } else {
      print('Invalid');
    }
  }

  // void _readData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? v = prefs.getString(StorageKeys.CHANNEL_ID);
  //   print(v);
  //   v = prefs.getString(StorageKeys.FIELD_COUNT);
  //   print(v);
  //   bool? b = prefs.getBool(StorageKeys.SAVE_STATUS);

  //   if (b == null) {
  //     print('bool null');
  //   }
  //   if (b == true) {
  //     print('bool true');
  //   }
  // }

  // void _clearData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Remove String
  //   prefs.remove(StorageKeys.CHANNEL_ID);
  //   //Remove bool
  //   prefs.remove(StorageKeys.FIELD_COUNT);
  //   //Remove int
  //   prefs.remove(StorageKeys.SAVE_STATUS);
  // }

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
            Heading(false),
            SubHeading('Setup'),
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

  // from layout
  Column setForm() {
    return Column(
      children: [
        // channel id
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

        // number of field
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

        // button to save
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
        ),
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
