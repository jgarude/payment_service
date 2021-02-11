import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        width: MediaQuery.of(context).size.width,
        height: 55,
        child: FlatButton(
          color: Color(0xFFFD5739),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ));
  }
}
