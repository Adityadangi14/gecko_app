import 'dart:developer';

import 'package:geeko_app/core/constants/api_constent.dart';
import 'package:geeko_app/core/data-state/data_state.dart';
import 'package:geeko_app/core/extensions/extensions.dart';
import 'package:geeko_app/core/network/request_params.dart';
import 'package:geeko_app/core/network/token_singleton.dart';
import 'package:geeko_app/core/shared-prefrences/shared_prefrences_singleton.dart';
import 'package:geeko_app/module/get-started/model/user_model.dart';
import 'package:geeko_app/module/get-started/services/get_user_service.dart';
import 'package:get/state_manager.dart';

class UserController extends GetxController {
  var isLoading = false.obs;
  var error = "".obs;

  var userModel = UserModel().obs;
  GetUserService getUserService = GetUserService();
  Future<void> getUser() async {
    try {
      DataState dataState = await getUserService.getUserService(RequestParams(
          url: "${ApiConstent.api}/getUser",
          apiMethods: ApiMethods.get,
          header: {
            "Content-Type": "application/json",
            "Token": TokenSingleton.instance.token
          }));

      if (dataState.exception != null) {
        error.value = dataState.exception!.getMessage;
        return;
      }

      log(dataState.data.toString());
      userModel.value = UserModel.fromJson(dataState.data);

      if (userModel.value.user != null) {
        log(userModel.value.user!.userName.toString());
        Prefs.setString("userName", userModel.value.user!.userName ?? "");
        Prefs.setString(
            "profilePicture", userModel.value.user!.profilePicture ?? "");

        Prefs.setBool(
            "areTagsChoosen", userModel.value.user!.areTagsChoosen ?? false);
      }
    } catch (e) {
      rethrow;
    }
  }
}
