import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geeko_app/core/constants/api_constent.dart';
import 'package:geeko_app/core/data-state/data_state.dart';
import 'package:geeko_app/core/network/request_params.dart';
import 'package:geeko_app/core/network/token_singleton.dart';
import 'package:geeko_app/core/shared-prefrences/shared_prefrences_singleton.dart';
import 'package:geeko_app/module/get-started/services/auth_service.dart';
import 'package:geeko_app/module/get-started/services/github_login_service.dart';
import 'package:geeko_app/module/get-started/services/google_login_service.dart';

import 'package:get/state_manager.dart';

class LoginController extends GetxController {
  GithubLoginService githubLoginService = GithubLoginService();
  GoogleLoginService googleLoginService = GoogleLoginService();
  AuthService authService = AuthService();

  var isLoggingIn = false.obs;

  Future<void> githubLoginController() async {
    isLoggingIn(true);
    await githubLoginService.signInWithGitHub();
    isLoggingIn(false);
  }

  Future<(bool, String)> googleLoginController() async {
    try {
      isLoggingIn(true);
      UserCredential userCredential =
          await googleLoginService.signInWithGoogle();

      if (userCredential.user != null) {
        DataState dataState = await authService.authService(RequestParams(
            url: "${ApiConstent.api}/auth",
            apiMethods: ApiMethods.post,
            header: {},
            body: {
              "UserName": userCredential.user!.displayName ?? "",
              "Email": userCredential.user!.email ?? "",
              "PID": userCredential.user!.uid,
              "ProfilePicture": userCredential.user!.photoURL ?? "",
              "AuthType": "Google"
            }));

        if (dataState.exception != null) {
          return (false, "Something went wrong. Unable to authenticate.");
        }

        log(dataState.data.toString());
        TokenSingleton.instance.token = dataState.data["token"];
        await Prefs.setString("Token", dataState.data["token"]);
        return (true, "Successfully authenticated");
      }
      isLoggingIn(false);

      return (true, "Something went wrong. Unable to authenticate.");
    } on Exception catch (e) {
      rethrow;
    }
  }
}
