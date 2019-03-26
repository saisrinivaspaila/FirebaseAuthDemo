import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'auth.dart';
import 'root.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Flutter Login',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Rootpage(auth: new Auth()),
    );
  }
}

