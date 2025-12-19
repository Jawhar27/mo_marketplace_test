import 'package:dio/dio.dart';
import 'package:mo_marketplace/core/utils/print_logs.dart';

LogInterceptor loggingInterceptor = LogInterceptor(
  request: true,
  requestHeader: true,
  requestBody: true,
  responseHeader: false,
  responseBody: true,
  error: true,
  logPrint: (obj) => printLogs(obj),
);
