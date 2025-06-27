import 'package:dio/dio.dart';

class ApiAgent {
  static final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

static Future<Response> post({
  required String url,
  required Map<String, dynamic> params,
  Map<String, String>? headers,

}) async {
  final mergedHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (headers != null) ...headers,
  };

  return await _dio.post(
    url,
    data: params,
    options: Options(headers: mergedHeaders),
  );
}
}

