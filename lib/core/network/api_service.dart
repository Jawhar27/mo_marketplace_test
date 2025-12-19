import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mo_marketplace/core/constants.dart';
import 'package:mo_marketplace/core/network/api_endpoints.dart';
import 'package:mo_marketplace/core/network/interceptors/auth_interceptor.dart';
import 'package:mo_marketplace/core/network/interceptors/connectivity_interceptor.dart';
import 'package:mo_marketplace/core/network/interceptors/logging_interceptor.dart';
import 'package:mo_marketplace/core/utils/custom_exceptions/api_exception.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(ref);
});

class ApiService {
  late final Dio _dio;

  ApiService(ref) {
    BaseOptions options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    );

    _dio = Dio(options);

    _dio.interceptors.addAll([
      ConnectivityInterceptor(),
      AuthInterceptor(_dio),
      loggingInterceptor,
    ]);
  }

  Future<Response> request(
    String path, {
    required HttpMethod method,
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      final options = Options(method: method.name, headers: headers);

      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParams,
        options: options,
      );

      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw ApiException(message: "Something went wrong", statusCode: 400);
    }
  }

  Exception _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ApiException(
        message: "Request timed out. Please try again.",
        statusCode: e.response?.statusCode,
      );
    } else if (e.type == DioExceptionType.badResponse) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 502 || statusCode == 500) {
        return ApiException(
          message: "Failed to connect to the server. Please try again!",
          statusCode: statusCode,
        );
      }
      if (statusCode == 404) {
        return ApiException(
          message: "Not found. Please try again!",
          statusCode: statusCode,
        );
      }
      if (statusCode == 401) {
        return ApiException(
          message:
              "Session expired. Please log in again to access your account.",
          statusCode: statusCode,
        );
      }
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          "Something went wrong, Please try again!";
      return ApiException(message: message, statusCode: statusCode);
    } else if (e.type == DioExceptionType.unknown) {
      final statusCode = e.response?.statusCode;
      return ApiException(
        message: "No Internet connection. Please try again!",
        statusCode: statusCode,
      );
    } else {
      final statusCode = e.response?.statusCode;
      return ApiException(
        message: "Something went wrong, Please try again!",
        statusCode: statusCode,
      );
    }
  }
}
