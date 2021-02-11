library paymentservice;

import 'package:flutter/material.dart';

import 'components/body.dart';

/// A Calculator.
class PaymentService extends StatelessWidget {
  static String routeName = "/payment_types";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
