import 'package:flutter/material.dart';
import 'main.dart';
import 'route_generator.dart';
import 'home.dart';
import 'book_cleaning.dart';
import 'payment.dart';

class BookCleaning extends StatelessWidget {
  const BookCleaning({Key? key}) : super(key: key);

  static const String title = 'Book a Cleaning';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(title),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const BookCleaningContent(),
    );
  }
}

class BookCleaningContent extends StatelessWidget {
  const BookCleaningContent({Key? key}) : super(key: key);

  static final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Shoe Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Pick Up Time',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Drop Off Time',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Location',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Phone Number',
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //const SizedBox(height: 30),
              ElevatedButton(
                style: style,
                onPressed: () {
                  Navigator.of(context).pushNamed('/Payment');
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
