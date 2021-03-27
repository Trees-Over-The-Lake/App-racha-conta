import 'package:flutter/material.dart';
import 'screens/menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP do racha conta',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple, canvasColor: Colors.amber[200]),
      initialRoute: Menu.routeName,
      routes: {Menu.routeName: (ctx) => Menu()},
    );
  }
}
