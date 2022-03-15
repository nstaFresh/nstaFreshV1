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
      this.shipped,
      this.pickUpDate,
      this.pickUpTime);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Widget _buildPopupDialog(String e, BuildContext context) {
    return new AlertDialog(
      title: const Text('Error'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Error: " +
              e.toString() +
              " Please alert 104ibrahimshah@gmail.com of the issue"),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

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

    Map<String, dynamic> paymentIntentData = jsonDecode(response.body);

    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData['clientSecret'],
            applePay: true,
            googlePay: true,
            style: ThemeMode.dark,
            merchantCountryCode: 'US',
            merchantDisplayName: 'Ibrahim Shah'));

    setState(() {});
    try{
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
      
        Navigator.of(context)
            .pushNamed('/PaymentComplete', arguments: information);
      });
    }
      catch (e) {
      if (e.toString() ==
          "Error: StripeException(error: LocalizedErrorMessage(code: FailureCode.Canceled, localizedMessage: The payment has been canceled, message: The payment has been canceled, stripeErrorCode: null, declineCode: null, type: null))") {
        print("payment cancelled");
      } else {
        print(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            _buildPopupDialog(e.toString(), context),
      );
      }
      
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
