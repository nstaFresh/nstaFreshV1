import 'package:flutter/material.dart';
import 'main.dart';
import 'route_generator.dart';
import 'home.dart';
import 'book_cleaning.dart';
import 'payment.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


class Payment extends StatefulWidget {
  const Payment({ Key? key }) : super(key: key);



  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ASDASD"),
      ),
        body: Center(
          child: ElevatedButton(
            child: Text("Pay here"),
            onPressed: (){
              
            },
          ),
        ),

      
    );
  }
}