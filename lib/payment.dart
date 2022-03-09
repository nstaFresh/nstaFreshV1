// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart';
import 'main.dart';
import 'route_generator.dart';
import 'home.dart';
import 'book_cleaning.dart';
import 'address.dart';
import 'payment.dart';
import 'payment_complete.dart';

class Payment extends StatefulWidget {
  //we need name, shoeName, description, phoneNumber, address line, postal code,
  //city, state, country

  final String name;
  final String shoeName;
  final String description;
  final String phoneNumber;
  final String addressLine;
  final String postalCode;
  final String city;
  final String state;
  final String country;

  const Payment(this.name, this.shoeName, this.description, this.phoneNumber,
      this.addressLine, this.postalCode, this.city, this.state, this.country);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Processing"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Press me to pay"),
          onPressed: () {
            print(widget.name);
            print(widget.shoeName);
            print(widget.description);
            print(widget.phoneNumber);
            print(widget.addressLine);
            print(widget.postalCode);
            print(widget.city);
            print(widget.state);
            print(widget.country);
            //print("ASDASD");
            makePayment();
          },
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    final url = Uri.parse(
        "https://nstafreshv2.ibrahimshah.repl.co/create-payment-intent");

    final response = await post(url, body: {
      "title": "Request for Payment Intent",
    });
    print(response);

    Map<String, dynamic> paymentIntentData = jsonDecode(response.body);
    print(paymentIntentData['clientSecret']);

    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData['clientSecret'],
            applePay: true,
            googlePay: true,
            style: ThemeMode.dark,
            merchantCountryCode: 'US',
            merchantDisplayName: 'Ibrahim Shah'));

    setState(() {});
    try {
      await Stripe.instance.presentPaymentSheet();
      setState(() {
        paymentIntentData['clientSecret'] = null;
        Navigator.of(context).pushNamed('/PaymentComplete');
      });
    } catch (e) {
      print(e);
    }
  }
}
