import 'package:geeko_app/core/constants/api_constent.dart';
import 'package:geeko_app/core/data-state/data_state.dart';
import 'package:geeko_app/core/extensions/extensions.dart';
import 'package:geeko_app/core/network/request_params.dart';
import 'package:geeko_app/core/network/token_singleton.dart';
import 'package:geeko_app/module/tags-selector.dart/model/tags_model.dart';
import 'package:geeko_app/module/tags-selector.dart/service/add_user_tags_service.dart';
import 'package:geeko_app/module/tags-selector.dart/service/get_tags_service.dart';
import 'package:get/state_manager.dart';

class TagsController extends GetxController {
  var isLoading = false.obs;
  var isAddingUserTags = false.obs;

  var tagsModel = TagsModel().obs;

  var selectedTags = [].obs;

  var error = "".obs;

  GetTagsService getTagsService = GetTagsService();
  AddUserTagsService addUserTagsService = AddUserTagsService();

  Future<(bool, String)> getTags() async {
    isLoading(true);
    try {
      DataState data = await getTagsService.getTagSrvice(RequestParams(
          url: "${ApiConstent.api}/getTags",
          apiMethods: ApiMethods.get,
          header: {
            "Content-Type": "application/json",
            "Token": TokenSingleton.instance.token
          }));
      isLoading(false);
      if (data.exception != null) {
        return (false, "Unable to fetch tags");
      }

      tagsModel.value = TagsModel.fromJson(data.data);

      return (true, "sucessfully fetched tags");
    } catch (e) {
      throw (e);
    }
  }

  Future<void> addUserTags() async {
    isAddingUserTags(true);
    try {
      DataState data = await addUserTagsService.addUserTagsService(
          RequestParams(
              url: "${ApiConstent.api}/createUserTags",
              apiMethods: ApiMethods.post,
              header: Header.header,
              body: {"TagsId": selectedTags.value}));

      if (data.exception != null) {
        error.value = data.exception!.getMessage;
        return;
      }
      isAddingUserTags(false);
    } catch (e) {
      throw (e);
    }
  }
}
