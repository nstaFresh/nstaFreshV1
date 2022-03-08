import 'package:flutter/material.dart';
import 'main.dart';
import 'route_generator.dart';
import 'payment_complete.dart';
import 'book_cleaning.dart';
import 'address.dart';
import 'payment.dart';
import 'payment_complete.dart';

class PaymentComplete extends StatelessWidget {
  const PaymentComplete({Key? key}) : super(key: key);

  static const String title = 'Payment Complete';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: const PaymentCompleteContent(),
    );
  }
}

class PaymentCompleteContent extends StatefulWidget {
  const PaymentCompleteContent({Key? key}) : super(key: key);

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
          Text('Payment complete! Thanks for using Nsta Fresh.', style: TextStyle(fontSize: 25),),
          const SizedBox(height: 30),
          ElevatedButton(
        style: style,
        onPressed: () {
          Navigator.of(context).pushNamed('/Home');
        },
        child: const Text('Home'),
      ),
      ],
      ),
    );
  }
}