import 'package:http/http.dart' as http;

// http client
class HttpPackageClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    print('--- intercept a request ---');
    return request.send();
  }
}
