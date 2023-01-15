// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
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

final Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
const authority = '192.168.1.35:8080';
const unencodedPath = '/transactions';
const headerAPI = {
  'password': '1000',
  'Content-Type': 'application/json',
};

Future<List<Transaction>> findAll() async {
  final url = Uri.http(authority, unencodedPath, {'q': 'dart'});
  final Response response = await client.get(url).timeout(const Duration(seconds: 5));
  final statusCode = response.statusCode;
  print('Esse é o código de retorno: $statusCode');
  if (statusCode != 200) return [];
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

Future<Transaction?> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    "value": transaction.value,
    "contact": {
      "name": transaction.contact.name,
      "accountNumber": transaction.contact.accountNumber,
    }
  };
  print("Vamos transferir"); 
  print(transactionMap);
  final bodyToSend = jsonEncode(transactionMap);
  final url = Uri.http(authority, unencodedPath, {'q': 'dart'});
  final Response response = await client
      .post(
        url,
        headers: headerAPI,
        body: bodyToSend,
      )
      .timeout(const Duration(seconds: 5));

  final statusCode = response.statusCode;
  print('Esse é o código de retorno: $statusCode');
  if (statusCode != 200) return null;
  final Map<String, dynamic> decodedJson = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = decodedJson['contact'];
  print(response);
  return Transaction(
    decodedJson['value'],
    Contact(
      0,
      contactJson['name'],
      contactJson['accountNumber'],
    ),
  );
}
