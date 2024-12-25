import 'package:dio/dio.dart';
import 'package:geeko_app/core/network/network.dart';
import 'package:geeko_app/module/get-started/controller/login_controller.dart';
import 'package:geeko_app/module/get-started/controller/user_controller.dart';
import 'package:geeko_app/module/homescreen/controller/blogsController.dart';
import 'package:geeko_app/module/tags-selector.dart/controller/tags_controller.dart';
import 'package:get/instance_manager.dart';

class Providers {
  static init() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => TagsController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => BlogsController());
  }
}
