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

  late AddressInfo infoForPayment;
  static TextEditingController addressLine1Controller = TextEditingController();
  static TextEditingController postalCodeController = TextEditingController();
  static TextEditingController cityController = TextEditingController();
  static TextEditingController stateController = TextEditingController();
  static TextEditingController pickUpDateController = TextEditingController();
  static TextEditingController pickUpTimeController = TextEditingController();

  bool shipped = false;
  // bool shipped = false;
  //isShipped _bool = isShipped.Yes;
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
                          //print(_bool);
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
                      //const SizedBox(height: 30),
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
                            print("fuck you");
                          } else {
                            //add the boolean for shipping/not shipping into this constructor
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

                            /*print(infoForPayment.name);
                              print(infoForPayment.shoeName);
                              print(infoForPayment.description);
                              print(infoForPayment.phoneNumber);
                              print(infoForPayment.addressLine);
                              print(infoForPayment.postalCode);
                              print(infoForPayment.city);
                              print(infoForPayment.state);*/

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
  //we need name, shoeName, description, phoneNumber, address line, postal code,
  //city, state,
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

  //add boolean for shipping or not shipping
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
