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
  //city, state, 

  final String name;
  final String shoeName;
  final String description;
  final String phoneNumber;
  final String addressLine;
  final String postalCode;
  final String city;
  final String state;

  const Payment(this.name, this.shoeName, this.description, this.phoneNumber,
      this.addressLine, this.postalCode, this.city, this.state);

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

    /*
                  (widget.name);
            print(widget.shoeName);
            print(widget.description);
            print(widget.phoneNumber);
            print(widget.addressLine);
            print(widget.postalCode);
            print(widget.city);
            print(widget.state);
    */

    Map<String, String> request = {
      "name": widget.name,
      "shoeName": widget.shoeName,
      "description": widget.description,
      "phoneNumber":widget.phoneNumber,
      "addressLine":widget.addressLine,
      "postalCode":widget.postalCode,
      "city":widget.city,
      "state":widget.state
    };
    final response = await post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(request),
    );
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
