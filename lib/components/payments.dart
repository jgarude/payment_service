class PaymentType {
  int paymentId;
  String title;
  String subTitle;

  PaymentType({this.paymentId, this.title, this.subTitle});

  static List<PaymentType> getPaymentTypes() {
    return <PaymentType>[
      PaymentType(
          paymentId: 1,
          title: 'Card/Debit Card',
          subTitle: 'Use your MasterCard, Visa and American Express'),
      PaymentType(
          paymentId: 2,
          title: 'Apple Pay',
          subTitle: 'Use the most secure payment option'),
      PaymentType(
          paymentId: 3,
          title: 'Pay Later',
          subTitle: 'Buy Now, Pay in 30 days (Powered by Tabby)'),
      PaymentType(
          paymentId: 4,
          title: 'Pay in Installments',
          subTitle: 'Pay in 3, 6, 9 or 12 months (Powered by Tabby)'),
      PaymentType(
          paymentId: 5,
          title: 'PayPal',
          subTitle: 'USD payment (Amount might vary in final billing)'),
    ];
  }
}
