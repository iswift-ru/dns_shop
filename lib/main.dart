import 'package:flutter/material.dart';
import 'my_widget.dart';
import 'package:dnsshop/extract_arguments_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Тестовое задание ДНС',

      home: MyWidget(),
      routes: {
          ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),

    },
    );
  }
}

