import 'package:dio/dio.dart';
import 'package:mo_marketplace/core/utils/print_logs.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    printLogs('AuthInterceptor - onRequest: ${options.method} ${options.path}');

    try {
      final token = getToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    } catch (e) {
      printLogs('AuthInterceptor - token fetch error: $e');
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      printLogs("*** 401 received, Trying to refresh token ****");
      final newToken = await _refreshToken();
      if (newToken != null && newToken.isNotEmpty) {
        printLogs("** Token Refreshed and Calling API Again ****");
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $newToken';

        try {
          final response = await dio.fetch(opts);
          return handler.resolve(response);
        } catch (e) {
          printLogs('Retry failed after token refresh: $e');
          if (e is DioException && e.response?.statusCode == 401) {
            _redirectToLogin();
          }
          return handler.reject(
            e is DioException
                ? e
                : DioException(requestOptions: err.requestOptions, error: e),
          );
        }
      } else {
        printLogs("Token refresh failed, redirecting to login");
        _redirectToLogin();
        return handler.reject(err);
      }
    }
    handler.next(err);
  }

  String? getToken() {
    return "";
  }

  void _redirectToLogin() async {
    printLogs("** Redirecting to SIGN IN ****");
    try {
      // SIGN OUT

      Future.delayed(const Duration(seconds: 1), () {
        // NAVIGATE TO SIGN IN SCREEN
      });
    } catch (e) {
      printLogs("Sign out error: $e");
    }
  }

  Future<String?> _refreshToken() async {
    try {
      //  REFRESH CLIENT
      // GET SESSION TOKEN
      return null;
    } catch (e) {
      printLogs('Token refresh error: $e');
      return null;
    }
  }
}
