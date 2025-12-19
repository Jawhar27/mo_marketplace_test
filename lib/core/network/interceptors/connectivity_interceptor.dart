import 'package:dio/dio.dart';
import 'package:mo_marketplace/core/utils/print_logs.dart';

class ConnectivityInterceptor extends Interceptor {
  final Dio _dioPing = Dio();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      await _dioPing.get(
        'https://www.google.com',
        options: Options(
          sendTimeout: Duration(seconds: 3),
          receiveTimeout: Duration(seconds: 3),
        ),
      );
      printLogs("Connectivity Interceptor - Internet is reachable");
      handler.next(options);
    } catch (e) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: "No Internet Connection",
          type: DioExceptionType.unknown,
        ),
      );
      printLogs("Connectivity Interceptor - Internet NOT reachable");
    }
  }
}
