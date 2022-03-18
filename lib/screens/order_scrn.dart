// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import "package:http/http.dart" as http;

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);
  static const String tokenizationKey = 'sandbox_9q9sd7s8_g93pfjx9y3w6x34c';
  var url = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                // var request = BraintreeDropInRequest(
                //   tokenizationKey: tokenizationKey,
                //   collectDeviceData: true,
                //   googlePaymentRequest: BraintreeGooglePaymentRequest(
                //     totalPrice: '10.00',
                //     currencyCode: 'USD',
                //     billingAddressRequired: false,
                //   ),
                //   paypalRequest: BraintreePayPalRequest(
                //     amount: '10.00',
                //     displayName: 'Salma Essam',
                //   ),
                //   cardEnabled: true,
                // );
                // final result = await BraintreeDropIn.start(request);
                // if (result != null) {
                //   print(result.paymentMethodNonce.description);
                //   print(result.paymentMethodNonce.nonce);

                  // final http.Response response = await http.post(Uri.tryParse($url?payment_method_nonce=${result.paymentMethodNonce.nonce}&device_data=${result.deviceData}));

                  // final payResult = jsonDecode(response.body);
                  // if (payResult['result'] == 'success') print('Payment Done');
                // }
              },
              child: const Text('Request Order?'),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     final request = BraintreeCreditCardRequest(
            //       cardNumber: '4111111111111111',
            //       expirationMonth: '12',
            //       expirationYear: '2021',
            //       cvv: '123',
            //     );
            //     final result = await Braintree.tokenizeCreditCard(
            //       tokenizationKey,
            //       request,
            //     );
            //     if (result != null) {
            //       print(result);
            //     }
            //   },
            //   child: Text('TOKENIZE CREDIT CARD'),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     final request = BraintreePayPalRequest(
            //       billingAgreementDescription:
            //           'I hereby agree that flutter_braintree is great.',
            //       displayName: 'Your Company',
            //     );
            //     final result = await Braintree.requestPaypalNonce(
            //       tokenizationKey,
            //       request,
            //     );
            //     if (result != null) {
            //       print(result);
            //     }
            //   },
            //   child: Text('PAYPAL VAULT FLOW'),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     final request = BraintreePayPalRequest(amount: '13.37');
            //     final result = await Braintree.requestPaypalNonce(
            //       tokenizationKey,
            //       request,
            //     );
            //     if (result != null) {
            //       print(result);
            //     }
            //   },
            //   child: Text('PAYPAL CHECKOUT FLOW'),
            // ),
          ],
        ),
      ),
    );
  }
}
