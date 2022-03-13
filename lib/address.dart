import 'package:flutter/material.dart';
import 'main.dart';
import 'route_generator.dart';
import 'home.dart';
import 'book_cleaning.dart';
import 'address.dart';
import 'payment.dart';
import 'payment_complete.dart';

class Address extends StatelessWidget {
  final String name;
  final String shoeName;
  final String description;
  final String phoneNumber;
  final String email;

  const Address(
      this.name, this.shoeName, this.description, this.phoneNumber, this.email);

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

  String getEmail() {
    return this.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
           

        title: Text(title),
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        
        child: AddressContent(getName()
        , getShoeName(), getDescription(),
          getPhoneNumber(), getEmail())
          )

    );
  }
}

class AddressContent extends StatefulWidget {
  final String name;
  final String shoeName;
  final String description;
  final String phoneNumber;
  final String email;
  const AddressContent(
      this.name, this.shoeName, this.description, this.phoneNumber, this.email);

  static final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  _AddressContentState createState() => _AddressContentState();
}

class _AddressContentState extends State<AddressContent> {
  _AddressContentState();

Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Error'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Please Complete All Dialogues"),
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

  late AddressInfo infoForPayment;
  static TextEditingController addressLine1Controller = TextEditingController();
  static TextEditingController postalCodeController = TextEditingController();
  static TextEditingController cityController = TextEditingController();
  static TextEditingController stateController = TextEditingController();
  static TextEditingController pickUpDateController = TextEditingController();
  static TextEditingController pickUpTimeController = TextEditingController();

  bool shipped = false;
 
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
                labelText: 'State (2 letter state code; e.g. IL)',
              ),
            ),
          ),
          
           Column(
              children: <Widget>[
                Container(
                  child: ListTile(
                    title: const Text('Shipping'),
                    leading: Radio<bool>(
                      value: true,
                      groupValue: shipped,
                      onChanged: (value) {
                        setState(() {
                          shipped = true;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  child: ListTile(
                    title: const Text('Drop Off/Pick Up'),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: shipped,
                      onChanged: (value) {
                        setState(() {
                          shipped = false;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                    child: (shipped == false)
                        ? 
                          Column(
                            mainAxisSize: MainAxisSize.min,
                              children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: TextFormField(
              controller: pickUpDateController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pick up date',
              ),
            ),
          ),
                                
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: TextFormField(
              controller: pickUpTimeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pick up time',
              ),
            ),
          ),
                                
                              ],
                            ): null),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          String name = widget.name;
                          String shoeName = widget.shoeName;
                          String description = widget.description;
                          String phoneNumber = widget.phoneNumber;
                          String email = widget.email;

                          if (shipped == true) {
                            pickUpDateController.text = '';
                            pickUpTimeController.text = '';
                          }

                          if (addressLine1Controller.text.isEmpty ||
                              postalCodeController.text.isEmpty ||
                              postalCodeController.text.length != 5 ||
                              cityController.text.isEmpty ||
                              stateController.text.isEmpty ||
                              stateController.text.length != 2 ||
                              (shipped == false &&
                                  (pickUpDateController.text.isEmpty ||
                                      pickUpTimeController.text.isEmpty))) {
                            showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                          } else {
                            AddressInfo infoForPayment = new AddressInfo(
                                name,
                                shoeName,
                                description,
                                phoneNumber,
                                email,
                                addressLine1Controller.text,
                                postalCodeController.text,
                                cityController.text,
                                stateController.text,
                                shipped,
                                pickUpDateController.text,
                                pickUpTimeController.text);

                          

                            Navigator.of(context).pushNamed('/Payment',
                                arguments: infoForPayment);
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          
        ]);
  }
}

class AddressInfo {
  
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

  AddressInfo(
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
}
