import 'package:flutter/material.dart';
import 'main.dart';
import 'route_generator.dart';
import 'home.dart';
import 'book_cleaning.dart';
import 'payment.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const String title = 'Nsta Fresh';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: const HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 30),
          ElevatedButton(
        style: style,
        onPressed: () {
          Navigator.of(context).pushNamed('/BookCleaning');
        },
        child: const Text('Book a Cleaning'),
      ),
      ],
      ),
    );
  }
}
