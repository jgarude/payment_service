import 'package:flutter/material.dart';
import '../card_details/card_details_screen.dart';
import '../default_button.dart';
import 'payments.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(22, 0, 0, 20),
                child: Text("Select Payment Method",
                    style: TextStyle(
                      fontFamily: 'Lato Bold',
                      fontSize: 18,
                    )),
              ),
              SizedBox(
                height: 22.0,
              ),
              PaymentOptions()
            ],
          )),
    );
  }
}

class PaymentOptions extends StatefulWidget {
  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  bool isSelected = false;
  List data;
  List<PaymentType> paymentTypes;
  PaymentType selectedPayment;

  @override
  void initState() {
    super.initState();
    paymentTypes = PaymentType.getPaymentTypes();
  }

  setSelectedPayment(PaymentType payment) {
    setState(() {
      selectedPayment = payment;
    });
  }

  List<Widget> createListOfPayementType() {
    List<Widget> widgets = [];
    for (PaymentType paymentType in paymentTypes) {
      widgets.add(
        Container(
          child: Card(
              child: Stack(
            children: [
              ListTile(
                title: Text(
                  paymentType.title,
                  style: TextStyle(
                      color: selectedPayment == paymentType
                          ? Colors.orangeAccent.shade700
                          : Colors.black,
                      fontFamily: selectedPayment == paymentType
                          ? 'Lato Bold'
                          : 'Lato Regular',
                      fontWeight: selectedPayment == paymentType
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 18),
                ),
                subtitle: Text(
                  paymentType.subTitle,
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontFamily: 'Lato Regular',
                      fontSize: 13.0,
                      fontWeight: FontWeight.normal),
                ),
                onTap: () {
                  setSelectedPayment(paymentType);
                },
                selected: selectedPayment == paymentType,
              ),
              Visibility(
                visible: selectedPayment == paymentType,
                child: Positioned(
                    right: 25,
                    top: 25.0,
                    child: Icon(
                      Icons.done,
                      color: Colors.orangeAccent.shade700,
                    )),
              ),
            ],
          )),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: createListOfPayementType(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
          child: DefaultButton(
            text: 'Continue',
            press: () {
              Navigator.pushNamed(context, '/congrats');
            },
          ),
        ),
      ],
    );
  }
}
