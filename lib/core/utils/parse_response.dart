import 'dart:developer';

import 'package:blog_app/core/model/base_model.dart';
import 'package:blog_app/core/utils/models/empyt_model.dart';



R? parseResponse<R, T extends BaseModel>(dynamic responseBody, T model) {
  try {
    if (responseBody is List) {
      return responseBody.map((data) => model.fromJson(data)).cast<T>().toList() as R;
    } else if (responseBody is Map<String, dynamic>) {
      return model.fromJson(responseBody) as R;
    } else {
      if (R is EmptyModel || R == EmptyModel) {
        return EmptyModel(name: responseBody.toString()) as R;
      } else {
        log('Becareful your data $responseBody, I could not parse it');
        return null;
      }
    }
  } catch (e) {
    log('Parse Error: $e - response body: $responseBody T model: $T , R model: $R ');
  }
  return null;
}
