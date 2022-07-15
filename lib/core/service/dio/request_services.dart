import 'dart:io';

import 'package:blog_app/core/model/base_model.dart';
import 'package:blog_app/core/service/dio/dio_exception.dart';
import 'package:blog_app/core/service/state/data_state.dart';
import 'package:blog_app/core/utils/parse_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class RequestServices {
  Future<DataState<T>> postRequest<T extends BaseModel>({
    required Dio dio,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    required String path,
    required T parserModel,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
        return DataSuccess(parseResponse(response.data, parserModel));
      } else {
        return DataFailed<T>(response.data["error"]["message"] ?? '');
      }
    } on DioError catch (error) {
      final errorMessage = DioException.fromDioError(error).toString();
      if (kDebugMode) {
        print("DioError $errorMessage");
      }
      return DataFailed<T>(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print("catch $e");
      }
      return DataFailed<T>(e.toString());
    }
  }

  Future<DataState<T>> getRequest<T extends BaseModel>({
    required Dio dio,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    required String path,
    required T parserModel,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
      );

      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(parseResponse(response.data, parserModel));
      } else {
        return DataFailed(response.statusMessage);
      }
    } on DioError catch (error) {
      final errorMessage = DioException.fromDioError(error).toString();
      if (kDebugMode) {
        print("DioError $errorMessage");
      }
      return DataFailed(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print("catch $e");
      }
      return DataFailed(e.toString());
    }
  }

  Future<DataState<List<T>>> getListRequest<T extends BaseModel>({
    required Dio dio,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    required String path,
    required T parserModel,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
      );

      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(parseResponse(response.data, parserModel));
      } else {
        return DataFailed(response.statusMessage);
      }
    } on DioError catch (error) {
      final errorMessage = DioException.fromDioError(error).toString();
      if (kDebugMode) {
        print("DioError $errorMessage");
      }
      return DataFailed(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print("catch $e");
      }
      return DataFailed(e.toString());
    }
  }

  Future<DataState<T>> putRequest<T extends BaseModel>({
    required Dio dio,
    Map<String, dynamic>? data,
    required String path,
    required T parserModel,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(parseResponse(response.data, parserModel));
      } else {
        return DataFailed(response.statusMessage);
      }
    } on DioError catch (error) {
      final errorMessage = DioException.fromDioError(error).toString();
      if (kDebugMode) {
        print("DioError $errorMessage");
      }
      return DataFailed(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print("catch $e");
      }
      return DataFailed(e.toString());
    }
  }

  Future<DataState<T>> deleteRequest<T extends BaseModel>({
    required Dio dio,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    required String path,
    required T parserModel,
  }) async {
    try {
      final response = await dio.delete(
        path,
        queryParameters: queryParameters,
        data: data,
      );

      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(parseResponse(response.data, parserModel));
      } else {
        return DataFailed(response.statusMessage);
      }
    } on DioError catch (error) {
      final errorMessage = DioException.fromDioError(error).toString();
      if (kDebugMode) {
        print("DioError $errorMessage");
      }
      return DataFailed(errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print("catch $e");
      }
      return DataFailed(e.toString());
    }
  }
}
