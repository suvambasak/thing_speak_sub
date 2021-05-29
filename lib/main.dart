import 'package:flutter/material.dart';
import 'package:thing_speak_sub/pages/tp_sub.dart';
import 'package:thing_speak_sub/pages/setup.dart';

void main() => runApp(
      MaterialApp(
        title: 'ThingSpeak Subscribe',
        initialRoute: "/setup",
        routes: {
          "/setup": (context) => Setup(),
          "/sub": (context) => TpSub(),
        },
      ),
    );
