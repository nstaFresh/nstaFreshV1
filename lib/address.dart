import 'package:flutter/material.dart';
import 'main.dart';
import 'route_generator.dart';
import 'home.dart';
import 'book_cleaning.dart';
import 'address.dart';
import 'payment.dart';
import 'payment_complete.dart';

//we need name, shoe name, description
class Address extends StatelessWidget {
  final String name;
  final String shoeName;
  final String description;
  final String phoneNumber;

  const Address(this.name, this.shoeName, this.description, this.phoneNumber);

  static const String title = 'Address Info';

  String getName() {
    return this.name;
  }

  String getShoeName() {
    return this.shoeName;
  }

  String getDescription() {
    return this.description;
  }

  String getPhoneNumber() {
    return this.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(name),
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: AddressContent(
          getName(), getShoeName(), getDescription(), getPhoneNumber()),
    );
  }
}

class AddressContent extends StatefulWidget {
  final String name;
  final String shoeName;
  final String description;
  final String phoneNumber;
  const AddressContent(
      this.name, this.shoeName, this.description, this.phoneNumber);

  static final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  _AddressContentState createState() => _AddressContentState(
      this.name, this.shoeName, this.description, this.phoneNumber);
}

class _AddressContentState extends State<AddressContent> {
  final String name;
  final String shoeName;
  final String description;
  final String phoneNumber;

  _AddressContentState(
      this.name, this.shoeName, this.description, this.phoneNumber);

  late AddressInfo infoForPayment;
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
                  String bruh = widget.name;
                  if (addressLine1Controller.text.isEmpty ||
                      postalCodeController.text.isEmpty ||
                      postalCodeController.text.length != 5 ||
                      cityController.text.isEmpty ||
                      stateController.text.isEmpty ||
                      countryController.text.isEmpty) {
                    print("fuck you");
                  } else {
                    print(this.name);
                    print(this.shoeName);
                    print(this.description);
                    print(this.phoneNumber);

                    AddressInfo infoForPayment = new AddressInfo(
                        this.name,
                        shoeName,
                        phoneNumber,
                        addressLine1Controller.text,
                        postalCodeController.text,
                        cityController.text,
                        stateController.text,
                        countryController.text);

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

class AddressInfo {
  //we need name, shoeName, description, phoneNumber, address line, postal code,
  //city, state, country
  final String name;
  final String shoeName;
  final String phoneNumber;
  final String addressLine;
  final String postalCode;
  final String city;
  final String state;
  final String country;

  AddressInfo(this.name, this.shoeName, this.phoneNumber, this.addressLine,
      this.postalCode, this.city, this.state, this.country);
}
