// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  CardModel({
    this.currencyCode,
    this.value,
    this.pan,
    this.expiry,
    this.cvv,
    this.cardholderName,
  });

  String currencyCode;
  int value;
  String pan;
  String expiry;
  String cvv;
  String cardholderName;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        currencyCode: json["currencyCode"],
        value: json["value"],
        pan: json["pan"],
        expiry: json["expiry"],
        cvv: json["cvv"],
        cardholderName: json["cardholderName"],
      );

  Map<String, dynamic> toJson() => {
        "currencyCode": currencyCode,
        "value": value,
        "pan": pan,
        "expiry": expiry,
        "cvv": cvv,
        "cardholderName": cardholderName,
      };
}
