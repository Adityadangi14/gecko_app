import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:geeko_app/core/shared-prefrences/shared_prefrences_singleton.dart';
import 'package:geeko_app/module/tags-selector.dart/controller/tags_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';

class TagsSelector extends StatefulWidget {
  const TagsSelector({super.key});

  @override
  State<TagsSelector> createState() => _TagsSelectorState();
}

class _TagsSelectorState extends State<TagsSelector> {
  TagsController tagsController = Get.find();

  @override
  void initState() {
    tagsController.getTags();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Obx(() => tagsController.isLoading.value ||
                tagsController.selectedTags.length < 10 ||
                tagsController.isAddingUserTags.value
            ? FloatingActionButton(
                backgroundColor: Colors.green[200]!,
                onPressed: null,
                child: Obx(() {
                  return tagsController.isAddingUserTags.value
                      ? const CircularProgressIndicator()
                      : const Icon(
                          Icons.chevron_right,
                          size: 30,
                        );
                }),
              )
            : FloatingActionButton(
                onPressed: () async {
                  await tagsController.addUserTags();
                  await Prefs.setBool("areTagsChoosen", true);

                  if (context.mounted) {
                    context.pushReplacement("/homeScreen");
                  }
                },
                child: const Icon(
                  Icons.chevron_right,
                  size: 30,
                ),
              )),
        body: Obx(() {
          return tagsController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Select what are you intrested in.",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                  text: "  (atleast 10)",
                                  style: TextStyle(
                                      color: Colors.green[400], fontSize: 14))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Obx(() {
                          return Wrap(
                            spacing: 20,
                            runSpacing: 1.w,
                            children:
                                tagsController.tagsModel.value.tags!.map((e) {
                              bool isSelcted =
                                  tagsController.selectedTags.contains(e.id);
                              return FilterChip(
                                backgroundColor: isSelcted
                                    ? Theme.of(context).primaryColor
                                    : Colors.green[200],
                                label: Text(
                                  e.tagName ?? "",
                                  style: TextStyle(
                                      color: isSelcted
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                onSelected: (value) {
                                  tagsController.selectedTags.contains(e.id)
                                      ? tagsController.selectedTags.remove(e.id)
                                      : tagsController.selectedTags.add(e.id);
                                },
                              );
                            }).toList(),
                          );
                        })
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
