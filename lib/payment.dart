// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Payment extends StatefulWidget {
  //we need name, shoeName, description, phoneNumber, address line, postal code,
  //city, state,

  final String name;
  final String shoeName;
  final String description;
  final String phoneNumber;
  final String email;
  final String addressLine;
  final String postalCode;
  final String city;
  final String state;
  final bool shipped;
  final String pickUpDate;
  final String pickUpTime;
  //add final boolean is shipped
  const Payment(
      this.name,
      this.shoeName,
      this.description,
      this.phoneNumber,
      this.email,
      this.addressLine,
      this.postalCode,
      this.city,
      this.state,
      this.shipped, //add in constructor
      this.pickUpDate,
      this.pickUpTime);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool isLoading = false;
  bool isLoadingNextScreen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: (isLoadingNextScreen)
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                child: (isLoading)
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          makePayment();
                        },
                        child: Text("Press to pay")),
              ),
            ),
    );
  }

  Future<void> makePayment() async {
    final url = Uri.parse(dotenv.env["API_URL"]!);

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
      "phoneNumber": widget.phoneNumber,
      "email": widget.email,
      "addressLine": widget.addressLine,
      "postalCode": widget.postalCode,
      "city": widget.city,
      "state": widget.state,
      "isShipped": widget.shipped.toString(),
      "pickUpDate": widget.pickUpDate,
      "pickUpTime": widget.pickUpTime
    };

    final response = await post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(request),
    );
    setState(() {
      isLoading = false;
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

    setState(() {
      //isLoadingNextScreen = true;
    });
    try {
      await Stripe.instance.presentPaymentSheet();
      setState(() {
        isLoadingNextScreen = true;
        paymentIntentData['clientSecret'] = null;
        PaymentInfo information = new PaymentInfo(
          widget.shipped,
          widget.email,
          widget.pickUpDate,
          widget.pickUpTime,
        );
        Navigator.of(context).pushNamed('/PaymentComplete',
            arguments: information

            //, arguments: create a class that just has the shipping as an instance variable
            );
      });
    } catch (e) {
      print(e);
    }
  }
}

class PaymentInfo {
  final bool shipped;
  final String email;
  final String pickUpDate;
  final String pickUpTime;
  PaymentInfo(this.shipped, this.email, this.pickUpDate, this.pickUpTime);
}
