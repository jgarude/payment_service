import 'package:flutter/material.dart';
import 'components/body.dart';

class CardDetailsScreen extends StatelessWidget {
  static String routeName = "/card_detail";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payments",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Body(),
    );
  }
}
