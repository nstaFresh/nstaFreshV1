import 'package:flutter/material.dart';
import 'main.dart';
import 'route_generator.dart';
import 'home.dart';
import 'book_cleaning.dart';
import 'address.dart';
import 'payment.dart';
import 'payment_complete.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/BookCleaning':
        return MaterialPageRoute(builder: (_) => BookCleaning());
      case '/Address':
        return MaterialPageRoute(builder: (BuildContext context) {
          final args = settings.arguments as BookCleaningInfo;
          return Address(
              args.name, args.shoeName, args.description, args.phoneNumber);
        });
      case '/Payment':
        return MaterialPageRoute(builder: (_) => Payment());
      case '/PaymentComplete':
        return MaterialPageRoute(builder: (_) => PaymentComplete());
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR!'),
        ),
      );
    });
  }
}
