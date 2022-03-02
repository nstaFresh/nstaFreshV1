import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'main.dart';
import 'route_generator.dart';
import 'home.dart';
import 'book_cleaning.dart';
import 'payment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.merchantIdentifier = 'Ibrahim Shah';
  Stripe.publishableKey = 'pk_test_pPq9ppt7qkZ1cNMBebnGtOlS';
  await Stripe.instance.applySettings();

  runApp(const MyApp());
}

//Color c = new Color.fromRGBO(0, 0, 0, 1.0);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      //theme: ThemeData(scaffoldBackgroundColor: c),
    );
  }
}
