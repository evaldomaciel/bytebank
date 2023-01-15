import 'dart:convert';

import 'package:bytebank/http/webClient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final url = Uri.http(authority, unencodedPath, {'q': 'dart'});
    final Response response = await client.get(url).timeout(const Duration(seconds: 5));
    final statusCode = response.statusCode;
    if (statusCode != 200) return [];
    List<Transaction> transactions = _toTransactions(response);
    return transactions;
  }
  
  Future<Transaction?> save(Transaction transaction) async {
    Map<String, dynamic> transactionMap = _toMap(transaction);
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
    if (statusCode != 200) return null;
    return _toTransaction(response);
  }

  List<Transaction> _toTransactions(Response response) {
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
    return transactions;
  }

  Transaction _toTransaction(Response response) {
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    final Map<String, dynamic> contactJson = decodedJson['contact'];
    return Transaction(
      decodedJson['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
  }

  Map<String, dynamic> _toMap(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
      "value": transaction.value,
      "contact": {
        "name": transaction.contact.name,
        "accountNumber": transaction.contact.accountNumber,
      }
    };
    return transactionMap;
  }
}
