import 'package:dio/dio.dart';

// interceptors
class DioInterceptor extends Interceptor {
  DioInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('--- intercept a request ---');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('--- intercept a response ---');
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('--- intercept an error ---');
    return handler.next(err);
  }
}

// http client
class DioPackageClient {
  final Dio _dio = Dio();

  DioPackageClient() {
    _dio.interceptors.add(DioInterceptor());

    // alternative way to configure interceptors

    // _dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (options, handler) {},
    //     onResponse: (response, handler) {},
    //     onError: (error, handler) {},
    //   ),
    // );
  }

  Dio get dio => _dio;
}
