import 'package:flutter/material.dart';
import 'main.dart';
import 'route_generator.dart';
import 'home.dart';
import 'book_cleaning.dart';
import 'address.dart';
import 'payment.dart';
import 'payment_complete.dart';

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

class BookCleaningContent extends StatefulWidget {
  const BookCleaningContent({Key? key}) : super(key: key);

  static final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  _BookCleaningContentState createState() => _BookCleaningContentState();
}

class _BookCleaningContentState extends State<BookCleaningContent> {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController shoeNameController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController phoneNumberController = TextEditingController();

  bool empty = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: TextFormField(
            controller: shoeNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Shoe Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description (example: lots of mud on bottom of sole)',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: TextFormField(
            controller: phoneNumberController,
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
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      shoeNameController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      phoneNumberController.text.isEmpty ||
                      phoneNumberController.text.length != 10) {
                    print("fuck you");
                  } else {
                    Navigator.of(context).pushNamed('/Address',
                        arguments: BookCleaningInfo(
                            nameController.text,
                            shoeNameController.text,
                            descriptionController.text,
                            phoneNumberController.text));
                  }
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BookCleaningInfo {
  final String name;
  final String shoeName;
  final String description;
  final String phoneNumber;

  const BookCleaningInfo(
      this.name, this.shoeName, this.description, this.phoneNumber);
}
