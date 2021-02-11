import '../../constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../default_button.dart';
import 'dart:async';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [CreditCardForm()],
      )),
    );
  }
}

class CreditCardForm extends StatefulWidget {
  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  Timer _timer;
  dynamic _card, _authenticated;
  bool isCardDetailsVisible = true;
  String _cardnumber;
  String _cardname;
  String _cardexpiry;
  String _cardcvv;
  bool rememberCard = false;
  bool isLoaderVisible = false;
  bool isLoader1Visible = false;
  bool is3dsButtonVisible = true;

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardExpiryDateController =
      TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<String> postData(
      String pan, String expiry, String cvv, String cardholderName) async {
    final String pathUrl = 'http://localhost:8000/api/ngenius_payment_init';
    dynamic data = {
      "currencyCode": "AED",
      "value": 10,
      "pan": pan,
      "expiry": expiry,
      "cvv": cvv,
      "cardholderName": cardholderName
    };

    var response = await Dio().post(pathUrl,
        data: data,
        options: Options(headers: {'Content-type': 'application/json'}));
    return response.data;
  }

  Future authenticate3ds() async {
    final String pathUrl =
        'http://localhost:8000/api/ngenius_payment_authenticate3ds';
    var response = await Dio().post(pathUrl,
        data: _card,
        options: Options(headers: {'Content-type': 'application/json'}));

    return response.data;
  }

  Widget _buildCardNumberField() {
    return TextFormField(
      controller: cardNumberController,
      decoration: InputDecoration(
        labelText: 'Credit Card Number',
        hintText: "Please enter a credit card number",
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      autofocus: true,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter a credit card number';
        }
      },
      onSaved: (String value) {
        _cardnumber = value;
      },
    );
  }

  Widget _builCardNameField() {
    return TextFormField(
      controller: cardNameController,
      decoration: InputDecoration(
        labelText: 'Name on the card',
        hintText: "Please enter a credit card holder name",
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      autofocus: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter a credit card holder name';
        }
      },
      onSaved: (String value) {
        _cardname = value;
      },
    );
  }

  Widget _buildCardExpiryField() {
    return TextFormField(
      controller: cardExpiryDateController,
      decoration: InputDecoration(
        labelText: "Card Expiry Date",
        hintText: "Please enter card expiry data",
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      autofocus: true,
      validator: (String value) {
        if (value.isEmpty) {
          return "Please enter card expiry data";
        }
      },
      onSaved: (String value) {
        _cardexpiry = value;
      },
    );
  }

  Widget _buildCardCvvField() {
    return TextFormField(
      controller: cardCvvController,
      decoration: InputDecoration(
        labelText: "CVV Number",
        hintText: "Please enter the card CVV number",
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      autofocus: true,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Please enter the card CVV number";
        }
      },
      onSaved: (String value) {
        _cardcvv = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _card == null
              ? isLoaderVisible
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(child: CircularProgressIndicator()),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Loading please wait..")
                        ],
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        Text(
                          "Enter Credit Card Details",
                          style: TextStyle(
                              fontFamily: 'Lato Bold',
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        _buildCardNumberField(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        _builCardNameField(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        _buildCardExpiryField(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        _buildCardCvvField(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                                value: rememberCard,
                                onChanged: (value) {
                                  setState(() {
                                    rememberCard = value;
                                  });
                                },
                                activeColor: kPrimaryColor),
                            Text(
                              'Save this card for future reference',
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Visibility(
                          visible: false,
                          child: Container(
                            child: Text('s'),
                          ),
                        ),
                        DefaultButton(
                          text: "Pay Now",
                          press: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              setState(() {
                                isLoaderVisible = true;
                              });
                              final String pan = cardNumberController.text;
                              final String cardholderName =
                                  cardNameController.text;
                              final String expiry =
                                  cardExpiryDateController.text;
                              final String cvv = cardCvvController.text;

                              dynamic data = await postData(
                                      pan, expiry, cvv, cardholderName)
                                  .then((value) => value);
                              setState(() {
                                final body = json.decode(data);
                                _card = body;
                                print(_card['md']);
                                isLoaderVisible = false;
                              });

                              //Navigator.pushNamed(context, OtpScreen.routeName);
                            }
                          },
                        ),
                      ],
                    )
              : Visibility(
                  visible: is3dsButtonVisible,
                  child: DefaultButton(
                    text: "Authenticate 3ds",
                    press: () async {
                      setState(() {
                        isLoader1Visible = true;
                        is3dsButtonVisible = false;
                      });
                      authenticate3ds();
                      dynamic dataAuthenticated =
                          await authenticate3ds().then((value) => value);

                      setState(() {
                        final authData = json.decode(dataAuthenticated);
                        _authenticated = authData;
                        // print('posting data 3ds');
                        // print(_authenticated['state']);
                      });
                    },
                  ),
                ),
          _authenticated == null
              ? isLoader1Visible
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(child: CircularProgressIndicator()),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Loading please wait..")
                        ],
                      ),
                    )
                  : Container()
              : _authenticated['state'] == 'CAPTURED' ||
                      _authenticated['state'] == 'AUTHORISED'
                  ? Navigation()
                  : Text('Error')
        ],
      ),
    );
  }
}

class Navigation extends StatefulWidget {
  Navigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Container(child: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return FutureBuilder(
      future: _confirm(),
      builder: (context, snapshot) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<String> _confirm() async {
    await Future.delayed(Duration.zero).then((value) {
      Navigator.pushNamed(context, '/congrats');
    });

    return "Logined";
  }
}
