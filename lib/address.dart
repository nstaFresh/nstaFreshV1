import 'package:flutter/material.dart';
import 'main.dart';
import 'route_generator.dart';
import 'home.dart';
import 'book_cleaning.dart';
import 'address.dart';
import 'payment.dart';
import 'payment_complete.dart';

class Address extends StatelessWidget {
  const Address({Key? key}) : super(key: key);

  static const String title = 'Address Info';

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
      body: const AddressContent(),
    );
  }
}

class AddressContent extends StatefulWidget {
  const AddressContent({Key? key}) : super(key: key);

  static final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  _AddressContentState createState() => _AddressContentState();
}

class _AddressContentState extends State<AddressContent> {
  static TextEditingController addressLine1Controller = TextEditingController();
  static TextEditingController postalCodeController = TextEditingController();
  static TextEditingController cityController = TextEditingController();
  static TextEditingController stateController = TextEditingController();
  static TextEditingController countryController = TextEditingController();

  bool empty = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: TextFormField(
            controller: addressLine1Controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Address Line 1',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: TextFormField(
            controller: postalCodeController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Postal Code',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: TextFormField(
            controller: cityController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'City',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: TextFormField(
            controller: stateController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'State',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: TextFormField(
            controller: countryController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Country',
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
                  if (addressLine1Controller.text.isEmpty || postalCodeController.text.isEmpty || postalCodeController.text.length != 5 || cityController.text.isEmpty || stateController.text.isEmpty || countryController.text.isEmpty) {
                    print("fuck you");
                  } else {
                    Navigator.of(context).pushNamed('/Payment');
                  }
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
