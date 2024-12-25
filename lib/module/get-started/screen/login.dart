import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:geeko_app/core/constants/assets_constant.dart';
import 'package:geeko_app/core/shared-prefrences/shared_prefrences_singleton.dart';
import 'package:geeko_app/module/get-started/controller/login_controller.dart';
import 'package:geeko_app/module/get-started/controller/user_controller.dart';
import 'package:geeko_app/widgets/utility.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:video_player/video_player.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late VideoPlayerController _controller;

  LoginController loginController = Get.find();
  UserController userController = Get.find();
  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(AssetsConstants.loginVideoContant)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> manageLogin() async {
    String? token = Prefs.getString("Token");

    log("Token ${token.toString()}");
    await userController.getUser();

    if (context.mounted) {
      if (userController.userModel.value.user!.areTagsChoosen == true) {
        Prefs.setString("profilePicture",
            userController.userModel.value.user!.profilePicture ?? "");
        Prefs.setString(
            "userName", userController.userModel.value.user!.userName ?? "");
        context.push("/homeScreen");
      } else {
        context.push("/tagSelector");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VideoPlayer(
            _controller,
          ),
          Container(
            width: 100.h,
            height: 100.h,
            color: Colors.black.withOpacity(0.5),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedTextKit(
                isRepeatingAnimation: false,
                repeatForever: false,
                animatedTexts: [
                  TypewriterAnimatedText('Inside Convoluted Engineering.',
                      speed: const Duration(milliseconds: 200),
                      textAlign: TextAlign.center,
                      textStyle: GoogleFonts.courierPrime(
                          color: Colors.white, fontSize: 16)),
                ],
                onTap: () {
                  print("Tap Event");
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialLoginButton(
                    backgroundColor: Colors.white,
                    height: 50,
                    text: '  Continue with Google',
                    textColor: Colors.black,
                    borderRadius: 20,
                    fontSize: 16,
                    buttonType: SocialLoginButtonType.google,
                    imageWidth: 20,
                    onPressed: () async {
                      Utility.stateLoader(context);
                      (bool, String) res =
                          await loginController.googleLoginController();

                      if (context.mounted && res.$1) {
                        await manageLogin();
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialLoginButton(
                    backgroundColor: Colors.black,
                    height: 50,
                    text: '  Continue with Github',
                    borderRadius: 20,
                    fontSize: 16,
                    buttonType: SocialLoginButtonType.github,
                    imageWidth: 25,
                    onPressed: () {
                      loginController.githubLoginController();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
