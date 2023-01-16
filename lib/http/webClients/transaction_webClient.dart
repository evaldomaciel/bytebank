import 'dart:convert';

import 'package:bytebank/http/webClient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final url = Uri.http(authority, unencodedPath, {'q': 'dart'});
    final Response response = await client.get(url).timeout(const Duration(seconds: 5));
    final statusCode = response.statusCode;
    if (statusCode != 200) return [];
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Transaction.fromJson(json)).toList();
  }

  Future<Transaction?> save(Transaction transaction) async {
    final bodyToSend = jsonEncode(transaction.toJson());
    final url = Uri.http(authority, unencodedPath, {'q': 'dart'});
    final Response response = await client.post(url, headers: headerAPI, body: bodyToSend).timeout(const Duration(seconds: 5));

    final statusCode = response.statusCode;
    if (statusCode != 200) return null;
    return Transaction.fromJson(jsonDecode(response.body));
  }
}
