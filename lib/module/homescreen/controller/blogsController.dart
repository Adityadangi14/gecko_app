import 'dart:developer';

import 'package:geeko_app/core/constants/api_constent.dart';
import 'package:geeko_app/core/data-state/data_state.dart';
import 'package:geeko_app/core/extensions/extensions.dart';
import 'package:geeko_app/core/network/request_params.dart';
import 'package:geeko_app/module/homescreen/model/blog_categories_model.dart';
import 'package:geeko_app/module/homescreen/model/blog_model.dart';
import 'package:geeko_app/module/homescreen/services/get_blog_categories_service.dart';
import 'package:geeko_app/module/homescreen/services/get_blogs_by_category.dart';
import 'package:geeko_app/module/homescreen/services/get_blogs_service.dart';
import 'package:get/state_manager.dart';

class BlogsController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMoreBlogs = false.obs;
  var isTrendingLoading = false.obs;
  var isCategoriesLoading = false.obs;
  var error = ''.obs;
  var blogModel = BlogModel().obs;

  var trendingBlogs = BlogModel().obs;

  var blogCategoriesModel = BlogCategoriesModel().obs;

  var pageNo = 1;

  var selectedCategoryIndex = 0.obs;
  var selectedCategoryName = "All";

  var isThemeDark = false.obs;

  final GetBlogsService _getBlogsService = GetBlogsService();
  final GetBlogByCategoryService _getBlogByCategoryService =
      GetBlogByCategoryService();
  final GetBlogsCategoriesService _getBlogsCategoriesService =
      GetBlogsCategoriesService();

  Future<void> getBlogs(int pageNo) async {
    try {
      DataState dataState = await _getBlogsService.getBlogsService(
          RequestParams(
              url: "${ApiConstent.api}/getBlogs?pageNo=$pageNo",
              apiMethods: ApiMethods.get,
              header: Header.header));

      if (dataState.exception != null) {
        error.value = dataState.exception!.getMessage;
        return;
      }

      if (pageNo == 1) {
        blogModel.value = BlogModel.fromJson(dataState.data);
      } else {
        blogModel.value.data!
            .addAll(BlogModel.fromJson(dataState.data).data!.toList());
        blogModel.refresh();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getTrendingBlogs() async {
    try {
      isTrendingLoading(true);

      DataState dataState = await _getBlogsService.getBlogsService(
          RequestParams(
              url: "${ApiConstent.api}/getTrendingBlogs",
              apiMethods: ApiMethods.get,
              header: Header.header));
      isLoading(false);
      log(dataState.data.toString());
      if (dataState.exception != null) {
        error.value = dataState.exception!.getMessage;
        return;
      }

      trendingBlogs.value = BlogModel.fromJson(dataState.data);

      isTrendingLoading(false);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getBlogCategories() async {
    try {
      isCategoriesLoading(true);

      DataState dataState = await _getBlogsCategoriesService
          .getBlogsCategoriesService(RequestParams(
              url: "${ApiConstent.api}/getBlogCategory",
              apiMethods: ApiMethods.get,
              header: Header.header));
      isLoading(false);
      log(dataState.data.toString());
      if (dataState.exception != null) {
        error.value = dataState.exception!.getMessage;
        return;
      }

      blogCategoriesModel.value = BlogCategoriesModel.fromJson(dataState.data);
      blogCategoriesModel.value.data!
          .insert(0, Data(categoryName: "All", tagsId: []));
      isCategoriesLoading(false);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getBlogByCategories(String catName) async {
    try {
      pageNo > 1 ? isLoadingMoreBlogs(true) : isLoading(true);

      if (catName != "All") {
        DataState dataState = await _getBlogsCategoriesService
            .getBlogsCategoriesService(RequestParams(
                url: "${ApiConstent.api}/getBlogByCategory?pageNo=$pageNo",
                apiMethods: ApiMethods.post,
                body: {
                  "CatName": catName,
                },
                header: Header.header));

        log(dataState.data.toString());
        if (dataState.exception != null) {
          error.value = dataState.exception!.getMessage;
          return;
        }

        if (pageNo == 1) {
          blogModel.value = BlogModel.fromJson(dataState.data);
        } else {
          blogModel.value.data!
              .addAll(BlogModel.fromJson(dataState.data).data!.toList());
          blogModel.refresh();
        }
      } else {
        await getBlogs(pageNo);
      }

      isCategoriesLoading(false);
    } catch (e) {
      rethrow;
    } finally {
      pageNo > 1 ? isLoadingMoreBlogs(false) : isLoading(false);
    }
  }
}
