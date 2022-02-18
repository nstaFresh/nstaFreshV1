import 'package:flutter/material.dart';
import 'route_generator.dart';
import 'home.dart';
import 'book_cleaning.dart';

void main() => runApp(const MyApp());

Color c = new Color.fromRGBO(0, 0, 0, 1.0);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(scaffoldBackgroundColor: c),
    );
  }
}
