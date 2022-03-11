import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'main.dart';
import 'route_generator.dart';
import 'home.dart';
import 'book_cleaning.dart';
import 'address.dart';
import 'payment.dart';
import 'payment_complete.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.merchantIdentifier = dotenv.env['MERCHANT_IDENTIFIER']!;
  Stripe.publishableKey = dotenv.env['PUBLISHABLE_KEY']!;
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
