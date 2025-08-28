import 'package:dio/dio.dart';
import 'package:riverpod_test/core/utils/logger.dart';

class ApiClient {
  final Dio _dio;
  final bool enableLogging;

  ApiClient({String? baseUrl, this.enableLogging = false})
      : _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl!,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  ) {
    if (enableLogging) {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            AppLogger.info(
              "➡️ REQUEST [${options.method}] ${options.uri}",
              name: "API",
            );
            if (options.data != null) {
              AppLogger.debug("Payload: ${options.data}", name: "API");
            }
            if (options.queryParameters.isNotEmpty) {
              AppLogger.debug("Query: ${options.queryParameters}", name: "API");
            }
            return handler.next(options);
          },
          onResponse: (response, handler) {
            AppLogger.info(
              "✅ RESPONSE [${response.statusCode}] ${response.requestOptions.uri}",
              name: "API",
            );
            AppLogger.debug("Data: ${response.data}", name: "API");
            return handler.next(response);
          },
          onError: (DioException e, handler) {
            AppLogger.error(
              "❌ ERROR [${e.response?.statusCode}] ${e.requestOptions.uri}",
              name: "API",
              error: e,
              stackTrace: e.stackTrace,
            );
            return handler.next(e);
          },
        ),
      );
    }
  }

  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> post<T>(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.post<T>(path,
          data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return Exception("Connection timeout. Please try again.");
    } else if (e.response != null) {
      return Exception(
          "Error: ${e.response?.statusCode} ${e.response?.statusMessage}");
    } else {
      return Exception("Unexpected error: ${e.message}");
    }
  }
}
