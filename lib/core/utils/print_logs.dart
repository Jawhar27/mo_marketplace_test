import 'dart:developer';

import 'package:mo_marketplace/core/network/api_endpoints.dart';

void printLogs(message) {
  if (isDev) {
    log(message.toString());
  }
}
