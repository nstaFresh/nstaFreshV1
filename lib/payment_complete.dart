import 'package:flutter/material.dart';
import 'main.dart';
import 'route_generator.dart';
import 'payment_complete.dart';
import 'book_cleaning.dart';
import 'address.dart';
import 'payment.dart';
import 'payment_complete.dart';

class PaymentComplete extends StatelessWidget {
  final bool shipped;
  final String email;
  final String pickUpDate;
  final String pickUpTime;
  PaymentComplete(this.shipped, this.email, this.pickUpDate, this.pickUpTime);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Complete"),
        automaticallyImplyLeading: false,
      ),
      body: PaymentCompleteContent(shipped, email, pickUpDate, pickUpTime
         ),
    );
  }
}

class PaymentCompleteContent extends StatefulWidget {
  final bool shipped;
  final String email;
  final String pickUpDate;
  final String pickUpTime;
  const PaymentCompleteContent(
      this.shipped, this.email, this.pickUpDate, this.pickUpTime);
  @override
  State<PaymentCompleteContent> createState() => _PaymentCompleteContentState();
}

class _PaymentCompleteContentState extends State<PaymentCompleteContent> {
 
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: (widget.shipped)
                  ? Text(
                      'Payment complete! Thanks for using Nsta Fresh. A shipping label will be sent to ${widget.email}',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      'Payment complete! Thanks for using Nsta Fresh. We will pick up the shoes on ${widget.pickUpDate} at ${widget.pickUpTime}',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
            child: const Text('Home'),
          ),
        ],
      ),
    );
  }
}
