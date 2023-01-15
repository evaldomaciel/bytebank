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

void findAll() async {
  final Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  final url = Uri.http('192.168.1.35:8080', '/transactions', {'q': 'dart'});
  final Response response = await client.get(url);
  print("We go to body");
  print(response.body);
}
