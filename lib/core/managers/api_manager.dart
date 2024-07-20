import 'dart:developer';

import 'package:dio/dio.dart';

import '../constants/app_constants.dart';

class ApiManager {
  final String baseUrl = kBaseUrl;
  bool showResponseData = false;
  bool showRequestData = false;
  final Dio _apiClient = Dio();
  final String _startBaseUrl = kBaseUrl;
  ApiManager() : super() {
    _apiClient.options.baseUrl = baseUrl;
  }
  void setToken(String token) {
    _apiClient.options.headers['Authorization'] = 'bearer $token';
  }

  Future<dynamic> getData(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    dynamic data,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool showResponseData = false,
    bool showRequestData = false,
  }) async {
    this.showResponseData = showResponseData;
    this.showRequestData = showRequestData;
    late Response response;
    try {
      log('getting data from ${_apiClient.options.baseUrl}$path');
      if (showRequestData) log(queryParameters.toString());
      response = await _apiClient.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (showResponseData) log(response.data.toString());
      return response.data;
    } on DioException catch (e) {
      log(e.response.toString());
      return Future.error(e.response?.data['detail'] ?? 'Erro ao realizar requisição');
    } catch (e) {
      log(e.toString());
      return Future.error(
        'Error on get: $e',
      );
    }
  }

  Future<Map<String, dynamic>> postData(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool showResponseData = false,
    bool showRequestData = false,
  }) async {
    this.showResponseData = showResponseData;
    this.showRequestData = showRequestData;
    late Response response;
    try {
      log('posting data to ${_apiClient.options.baseUrl}$path');
      if (showRequestData) log(data.toString());

      response = await _apiClient.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      log(e.response.toString());
      return Future.error(e.response?.data['detail'] ?? 'Erro ao realizar requisição');
    } catch (e) {
      return Future.error(
        'Error on post: $e',
      );
    }
  }

  Future<dynamic> putData(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool showResponseData = false,
  }) async {
    this.showResponseData = showResponseData;
    late Response response;
    try {
      log('putting data from ${_apiClient.options.baseUrl}$path');
      if (showRequestData) log(data.toString());
      response = await _apiClient.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      log(e.response.toString());
      return Future.error(e.response?.data['detail'] ?? 'Erro ao realizar requisição');
    } catch (e) {
      return Future.error(
        'Error on put: $e',
      );
    }
  }

  Future<dynamic> deleteData(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool showResponseData = false,
  }) async {
    this.showResponseData = showResponseData;
    late Response response;
    try {
      // talker.log('deleting data from ${_apiClient.options.baseUrl}$path', logLevel: LogLevel.info);
      response = await _apiClient.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      return Future.error(
        'Error on delete: ${e.response} and ${e.response}',
      );
    } catch (e) {
      return Future.error(
        'Error on delete: $e',
      );
    }
  }

  void overrideResponseData(bool value) {
    showResponseData = value;
  }

  void overrideBaseUrl(String baseUrl) {
    _apiClient.options.baseUrl = baseUrl;
  }

  void resetBaseUrl() {
    _apiClient.options.baseUrl = _startBaseUrl;
  }
}
