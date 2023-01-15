// ignore_for_file: avoid_print

import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
const authority = '192.168.1.35:8080';
const unencodedPath = '/transactions';
const headerAPI = {
  'password': '1000',
  'Content-Type': 'application/json',
};
