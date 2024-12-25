import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:geeko_app/core/network/token_singleton.dart';
import 'package:geeko_app/core/providers/providers.dart';
import 'package:geeko_app/core/routes/routes.dart';
import 'package:geeko_app/core/shared-prefrences/shared_prefrences_singleton.dart';
import 'package:geeko_app/core/theme/app_theme.dart';
import 'package:geeko_app/module/homescreen/controller/blogsController.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAhBQ4VXZHA3blGBrII_a47RUE3fLsuZ-w',
          appId: '1:161167161212:android:a5bf028ac1ae09154d96f9',
          messagingSenderId: '',
          projectId: 'gecko-d13cf'));

  Providers.init();

  await Prefs.init();

  TokenSingleton.instance.token = Prefs.getString("Token") ?? "";

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final BlogsController blogsController = Get.find();

  @override
  void initState() {
    // TODO: implement initState

    final bool? res = Prefs.getBool("appTheme");

    if (res != null) {
      blogsController.isThemeDark.value = res;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(builder: (context, orientation, screenType) {
      return Obx(() {
        return MaterialApp.router(
            routerConfig: router,
            title: 'Gecko',
            theme: blogsController.isThemeDark.value
                ? AppTheme.darkTheme(context)
                : AppTheme.lightTheme(context));
      });
    });
  }
}
