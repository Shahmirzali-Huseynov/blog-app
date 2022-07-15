// ignore_for_file: file_names

import 'package:blog_app/core/model/status_model.dart';

abstract class INetworkDioManager<T> {
  INetworkDioManager<T> addBaseUrl(String baseUrl);
  INetworkDioManager<T> addStatusModels(StatusModels? statusModels);
  INetworkDioManager<T> addBaseHeader(MapEntry<String, String> value);
  INetworkDioManager<T> addTimeout(int value);
  INetworkDioManager<T> addLoggerRequest();

  T build();
}
