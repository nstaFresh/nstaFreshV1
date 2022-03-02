// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'main.dart';
import 'route_generator.dart';
import 'home.dart';
import 'book_cleaning.dart';
import 'payment.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

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
            //print("ASDASD");
            makePayment();
          },
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    final url = Uri.parse("https://nstafreshv2.ibrahimshah.repl.co/create-payment-intent");

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
      });
    } catch (e) {
      print(e);
    }
  }
}
