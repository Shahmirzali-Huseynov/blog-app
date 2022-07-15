import 'package:blog_app/core/model/status_model.dart';
import 'package:blog_app/core/service/dio/INetwork_dio_manager.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class NetworkDioManager implements INetworkDioManager<Dio> {
  Dio? _dio;
  String? _baseUrl;
  StatusModels? _statusModels;
  MapEntry<String, String>? _baseHeader;
  int? _timeOut;
  InterceptorsWrapper? _wrapper;

  @override
  INetworkDioManager<Dio> addBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
    return this;
  }

  @override
  INetworkDioManager<Dio> addTimeout(int value) {
    _timeOut = value;
    return this;
  }

  @override
  INetworkDioManager<Dio> addStatusModels(StatusModels? statusModels) {
    _statusModels = statusModels;
    return this;
  }

  @override
  INetworkDioManager<Dio> addBaseHeader(MapEntry<String, String> value) {
    _baseHeader = value;
    return this;
  }

  @override
  INetworkDioManager<Dio> addLoggerRequest() {
    _wrapper = InterceptorsWrapper(
      // onRequest: (options, handler) {
      //   Logger().log(Level.info, options);
      //   handler.next(options);
      // },
      onError: (dioError, handler) {
        Logger().e(dioError);
        handler.next(dioError);
      },
    );
    return this;
  }

  @override
  Dio build() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl ?? '',
      headers: Map.fromEntries([_baseHeader ?? const MapEntry('Content-type', 'application/json')]),
      connectTimeout: _timeOut,
      validateStatus: (status) {
        if (status != null && _statusModels != null) {
          if (status >= _statusModels!.minumumValue && status < _statusModels!.maximumValue) {
            return true;
          }
        }

        return false;
      },
    ));

    if (_wrapper != null) {
      _dio?.interceptors.add(_wrapper!);
    }

    return _dio!;
  }
}
