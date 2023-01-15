import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print("We go to request data");
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("We go to response data");
    print(data.statusCode.toString());
    print(data.toString());
    return data;
  }
}

Future<List<Transaction>> findAll() async {
  final Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final url = Uri.http('192.168.1.35:8080', '/transactions', {'q': 'dart'});
  final Response response = await client.get(url);
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final list = Transaction(
      transactionJson['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transactions.add(list);
  }
  debugPrint(transactions.toString());
  return transactions;
}
