import 'package:flutter/material.dart';
import 'main.dart';
import 'route_generator.dart';
import 'payment_complete.dart';
import 'book_cleaning.dart';
import 'address.dart';
import 'payment.dart';
import 'payment_complete.dart';

class PaymentComplete extends StatelessWidget {
  //add isShipped as part of the constructor 
  const PaymentComplete({Key? key}) : super(key: key);

  static const String title = 'Payment Complete';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        automaticallyImplyLeading: false,
      ),
      body: const PaymentCompleteContent(/**add a isShipped paramter to this cojnstrucotr */),
    );
  }
}

class PaymentCompleteContent extends StatefulWidget {
  const PaymentCompleteContent({Key? key}) : super(key: key);
  //add isSHIpped param
  @override
  State<PaymentCompleteContent> createState() => _PaymentCompleteContentState();
}

class _PaymentCompleteContentState extends State<PaymentCompleteContent> {
  //how to access in the state class: 
  //once inside widget build metod, you can just do widget.isShipped 
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
              child: Text(
            'Payment complete! Thanks for using Nsta Fresh.',
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
