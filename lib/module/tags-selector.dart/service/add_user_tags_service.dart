import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geeko_app/core/data-state/data_state.dart';
import 'package:geeko_app/core/network/network.dart';
import 'package:geeko_app/core/network/request_params.dart';

class AddUserTagsService {
  NetworkManager networkManager = NetworkManager(dio: Dio());

  Future<DataState> addUserTagsService(RequestParams requestParams) async {
    Response response = await networkManager.apiCall(
        url: requestParams.url,
        requestType: ApiMethods.post,
        body: requestParams.body,
        header: requestParams.header);

    if (response.statusCode == 200) {
      return DataSuccess(response.data);
    } else {
      log(response.data.toString());
      return DataFailed(Exception("Unable to process resquest"));
    }
  }
}
