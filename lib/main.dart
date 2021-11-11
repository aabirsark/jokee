import 'package:flutter/material.dart';
import 'package:jokee/constants.dart';
import 'package:jokee/pages/home.dart';

void main() => runApp(const Jokee());

class Jokee extends StatelessWidget {
  const Jokee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const Home(),
    );
  }
}
