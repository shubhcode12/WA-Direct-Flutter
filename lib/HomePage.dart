import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsappdirect/Constants.dart' as cst;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final phoneController = new TextEditingController();
  final msgController = new TextEditingController();
  var _selectedCountrycode;
  final snackBar = SnackBar(content: Text('Content cleared. Yey!'));

  sendDirectMassage() {
    var phoneNo = phoneController.text;
    var msg = msgController.text;

    print(_selectedCountrycode);

    if (phoneNo == '') {
      print('phone number is empty');
    } else {
      launch(
          'https://api.whatsapp.com/send?phone=${_selectedCountrycode}${phoneNo}&text=${msg}');
      //print(phoneNo);
    }

    if (msg == '') {
      print('msg is empty');
    } else {
      print(msg);
    }
  }

  clearTextFields() {
    phoneController.clear();
    msgController.clear();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WA Direct'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20, top: 20, right: 0),
              child: Text(
                'Hey Fellas!',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Rubik',
                    fontSize: 36,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1),
              )),
          Container(
            padding: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Text(
                'Welcome to WA Direct, send message to whatsapp without saving phone number'),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 30, right: 10),
            child: Column(children: <Widget>[
              Row(
                children: [
                  Card(
                    elevation: 8,
                    child: CountryCodePicker(
                        initialSelection: 'in',
                        onChanged: print,
                        favorite: ['in'],
                        onInit: (value) {
                          _selectedCountrycode = value.dialCode;
                        }),
                  ),
                  Card(
                    elevation: 8,
                    child: Container(
                      width: 250,
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter Phone Number"),
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                elevation: 8,
                child: Container(
                  child: TextField(
                    maxLines: 10,
                    minLines: 2,
                    controller: msgController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter your massage"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: MaterialButton(
                        minWidth: 200,
                        child: Text('Send'),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          print(sendDirectMassage());
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: MaterialButton(
                        child: Text('Clear'),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          clearTextFields();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
